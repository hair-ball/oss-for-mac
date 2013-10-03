//
//  AFOSSClient.h
//  OSS
//
//  Created by di wu on 10/3/13.
//  Copyright (c) 2013 di wu. All rights reserved.
//
#import <AFNetworking.h>

@interface AFOSSClient : AFHTTPClient

@property(nonatomic,strong)NSURL *baseURL;

@property (nonatomic, copy) NSString *bucket;

@property (nonatomic, copy) NSString *region;

- (id)initWithAccessKeyID:(NSString *)accessKey
                   secret:(NSString *)secret;

- (NSDictionary *)authorizationHeadersForRequest:(NSMutableURLRequest *)request;

- (void)enqueueOSSRequestOperationWithMethod:(NSString *)method
                                       path:(NSString *)path
                                 parameters:(NSDictionary *)parameters
                                    success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSError *error))failure;

- (void)getBucketsWithSuccess:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure;

- (void)getBucket:(NSString *)bucket
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure;
@end
