//
//  AFOSSClient.m
//  OSS
//
//  Created by di wu on 10/3/13.
//  Copyright (c) 2013 di wu. All rights reserved.
//

#import "AFOSSClient.h"
#import <CommonCrypto/CommonHMAC.h>
static NSString * const AFAmazonS3ClientDefaultBaseURLString = @"http://oss.aliyuncs.com";
NSString * const AFAmazonS3USStandardRegion = @"oss.aliyuncs.com";
static NSData * AFHMACSHA1EncodedDataFromStringWithKey(NSString *string, NSString *key) {
    NSData *data = [string dataUsingEncoding:NSASCIIStringEncoding];
    CCHmacContext context;
    const char *keyCString = [key cStringUsingEncoding:NSASCIIStringEncoding];
    
    CCHmacInit(&context, kCCHmacAlgSHA1, keyCString, strlen(keyCString));
    CCHmacUpdate(&context, [data bytes], [data length]);
    
    unsigned char digestRaw[CC_SHA1_DIGEST_LENGTH];
    NSInteger digestLength = CC_SHA1_DIGEST_LENGTH;
    
    CCHmacFinal(&context, digestRaw);
    
    return [NSData dataWithBytes:digestRaw length:digestLength];
}

static NSString * AFRFC822FormatStringFromDate(NSDate *date) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss z"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    
    return [dateFormatter stringFromDate:date];
}

NSString * AFBase64EncodedStringFromData(NSData *data) {
    NSUInteger length = [data length];
    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *input = (uint8_t *)[data bytes];
    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
    
    for (NSUInteger i = 0; i < length; i += 3) {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        static uint8_t const kAFBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length ? kAFBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
        output[idx + 3] = (i + 2) < length ? kAFBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
}
@interface AFOSSClient ()
@property (readwrite, nonatomic, copy) NSString *accessKey;
@property (readwrite, nonatomic, copy) NSString *secret;

- (void)setObjectWithMethod:(NSString *)method
                       file:(NSString *)filePath
            destinationPath:(NSString *)destinationPath
                 parameters:(NSDictionary *)parameters
                   progress:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progressBlock
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;
@end
@implementation AFOSSClient
@synthesize baseURL = _oss_baseURL;
@synthesize bucket = _bucket;
@synthesize region = _region;
@synthesize accessKey = _accessKey;
@synthesize secret = _secret;
- (id)initWithAccessKeyID:(NSString *)accessKey
                   secret:(NSString *)secret
{
    self = [self initWithBaseURL:[NSURL URLWithString:AFAmazonS3ClientDefaultBaseURLString]];
    if (!self) {
        return nil;
    }
    
    // Workaround for designated initializer of subclass
    self.baseURL = [NSURL URLWithString:AFAmazonS3ClientDefaultBaseURLString];
    
    self.accessKey = accessKey;
    self.secret = secret;
    
    return self;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFXMLRequestOperation class]];
    
    return self;
}
- (void)setBucket:(NSString *)bucket {
    [self willChangeValueForKey:@"baseURL"];
    [self willChangeValueForKey:@"bucket"];
    _bucket = bucket;
    [self didChangeValueForKey:@"bucket"];
    [self didChangeValueForKey:@"baseURL"];
}
- (NSURL *)baseURL {
    return [NSURL URLWithString:AFAmazonS3ClientDefaultBaseURLString];
}
- (NSDictionary *)authorizationHeadersForRequest:(NSMutableURLRequest *)request {
    if (self.accessKey && self.secret) {
        // Long header values that are subject to "folding" should split into new lines according to AWS's documentation.
		NSMutableDictionary *mutableOSSHeaderFields = [NSMutableDictionary dictionary];
		[[request allHTTPHeaderFields] enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
			key = [key lowercaseString];
			if ([key hasPrefix:@"x-oss"]) {
				if ([mutableOSSHeaderFields objectForKey:key]) {
					value = [[mutableOSSHeaderFields objectForKey:key] stringByAppendingFormat:@",%@", value];
				}
				[mutableOSSHeaderFields setObject:value forKey:key];
			}
		}];
        
		NSMutableString *mutableCanonicalizedOSSHeaderString = [NSMutableString string];
		for (NSString *key in [[mutableOSSHeaderFields allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
            id value = [mutableOSSHeaderFields objectForKey:key];
			[mutableCanonicalizedOSSHeaderString appendFormat:@"%@:%@\n", key, value];
		}
        
        NSString *canonicalizedResource = [NSString stringWithFormat:@"%@%@", self.bucket?self.bucket:@"", request.URL.path];
    	NSString *method = [request HTTPMethod];
		NSString *contentMD5 = [request valueForHTTPHeaderField:@"Content-MD5"];
		NSString *contentType = [request valueForHTTPHeaderField:@"Content-Type"];
		NSString *date = AFRFC822FormatStringFromDate([NSDate date]);
        
		NSMutableString *mutableString = [NSMutableString string];
		[mutableString appendFormat:@"%@\n", (method) ? method : @""];
		[mutableString appendFormat:@"%@\n", (contentMD5) ? contentMD5 : @""];
		[mutableString appendFormat:@"%@\n", (contentType) ? contentType : @""];
		[mutableString appendFormat:@"%@\n", (date) ? date : @""];
		[mutableString appendFormat:@"%@", mutableCanonicalizedOSSHeaderString];
		[mutableString appendFormat:@"%@", canonicalizedResource];
        
        NSData *hmac = AFHMACSHA1EncodedDataFromStringWithKey(mutableString, self.secret);
        NSString *signature = AFBase64EncodedStringFromData(hmac);
        NSLog(@"DICT DICT %@",@{@"Authorization": [NSString stringWithFormat:@"OSS %@:%@", self.accessKey, signature],
                                @"Date": (date) ? date : @""
                                });
        return @{@"Authorization": [NSString stringWithFormat:@"OSS %@:%@", self.accessKey, signature],
                 @"Date": (date) ? date : @""
                 };
    }
    
    return nil;
}
#pragma mark -

- (void)enqueueOSSRequestOperationWithMethod:(NSString *)method
                                       path:(NSString *)path
                                 parameters:(NSDictionary *)parameters
                                    success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSError *error))failure
{
    NSURLRequest *request = [self requestWithMethod:method path:path parameters:parameters];
    
    AFHTTPRequestOperation *requestOperation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            NSLog(@"melon %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    [self enqueueHTTPRequestOperation:requestOperation];
}

#pragma mark Service Operations

- (void)getBucketsWithSuccess:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure
{
    [self enqueueOSSRequestOperationWithMethod:@"GET" path:@"/" parameters:nil success:success failure:failure];
}

- (void)getBucket:(NSString *)bucket
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure
{
    [self enqueueOSSRequestOperationWithMethod:@"GET" path:bucket parameters:nil success:success failure:failure];
}

#pragma mark - AFHTTPClient

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters
{
	NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:parameters];
    
    [[self authorizationHeadersForRequest:request] enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL *stop) {
        [request setValue:value forHTTPHeaderField:field];
    }];
    
    return request;
}
@end
