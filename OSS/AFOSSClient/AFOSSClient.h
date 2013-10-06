//
//  AFOSSClient.h
//  OSS
//
//  Created by di wu on 10/3/13.
//  Copyright (c) 2013 di wu. All rights reserved.
//
#import <AFNetworking.h>

@interface AFOSSClient : AFHTTPClient

@property(nonatomic, strong) NSURL *baseURL;

@property(nonatomic, copy) NSString *bucket;

@property(nonatomic, copy) NSString *region;


/**
 *  Initializes a new OSS client with access key and serect
 *
 *  @param accessKey the OSS access key
 *  @param secret    the oss secret
 *
 *  @return OSS Client
 */
- (id)initWithAccessKeyID:(NSString *)accessKey
                   secret:(NSString *)secret;



/**
 *  Returens OSS authorization HTTP header
 *
 *  @param request the request
 *
 *  @return authorization header
 */
- (NSDictionary *)authorizationHeadersForRequest:(NSMutableURLRequest *)request;


/**
 *  Create and enqueues a request
 *
 *  @param method     Http method
 *  @param path       Request path
 *  @param success    A block object to be executed when the request operation finishes successfully
 *  @param failure    A block object to be executed when the request operation finishes unsuccessfully
 */
- (void)enqueueOSSRequestOperationWithMethod:(NSString *)method
                                        path:(NSString *)path
                                  parameters:(NSDictionary *)parameters
                                     success:(void (^)(id responseObject))success
                                     failure:(void (^)(NSError *error))failure;


/**
 *  List of all buckets of the authenticated sender
 */
- (void)getBucketsWithSuccess:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure;

/**
 *  List all objects in the bucket
 *
 *  @param bucket  bucket name
 */
- (void)getBucket:(NSString *)bucket
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure;

/**
 *  Create a new bucket belonging the authenticated request sender
 *
 *  @param bucket     bucket name
 */
- (void)putBucket:(NSString *)bucket
       parameters:(NSDictionary *)parameters
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure;


/**
 *  Delete the bucket beloging authenticated request sender
 *
 *  @param bucket  bucket name
 */
- (void)deleteBucket:(NSString *)bucket
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSError *error))failure;

/**
 Retrieves information about an object for a user with read access without fetching the object.
 
 @param path The object path.
 */
- (void)headObjectWithPath:(NSString *)path
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;

/**
 *  Create and enqueues a request
 *
 *  @param method          <#method description#>
 *  @param filePath        <#filePath description#>
 *  @param destinationPath <#destinationPath description#>
 *  @param parameters      <#parameters description#>
 *  @param progressBlock   <#progressBlock description#>
 *  @param success         <#success description#>
 *  @param failure         <#failure description#>
 */
- (void)setObjectWithMethod:(NSString *)method
                       file:(NSString *)filePath
            destinationPath:(NSString *)destinationPath
                 parameters:(NSDictionary *)parameters
                   progress:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progressBlock
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;
/**
 *  Gets an object for a user that has read access to the object.
 *
 *  @param path     the object path
 */
- (void)getObjectWithPath:(NSString *)path
                 progress:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))progress
                  success:(void (^)(id responseObject, NSData *responseData))success
                  failure:(void (^)(NSError *error))failure;

/**
 *  Gets an object for a user that has read access to the object.
 *
 *  @param path         path The object path.
 *  @param outputStream The `NSOutputStream` object receiving data from the request.
 */
- (void)getObjectWithPath:(NSString *)path
             outputStream:(NSOutputStream *)outputStream
                 progress:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))progress
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

/**
 *   Adds an object to a bucket using forms.
 *
 *  @param path            The path to the local file.
 *  @param destinationPath The destination path for the remote file.
 *  @param parameters      <#parameters description#>
 *  @param progress        <#progress description#>
 *  @param success         <#success description#>
 *  @param failure         <#failure description#>
 */
- (void)postObjectWithFile:(NSString *)path
           destinationPath:(NSString *)destinationPath
                parameters:(NSDictionary *)parameters
                  progress:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;

/**
 *  Adds an object to a bucket for a user that has write access to the bucket
 *
 *  @param path            The path to the local file.
 *  @param destinationPath The destination path for the remote file.
 *  @param parameters      <#parameters description#>
 *  @param progress        <#progress description#>
 *  @param success         <#success description#>
 *  @param failure         <#failure description#>
 */
- (void)putObjectWithFile:(NSString *)path
          destinationPath:(NSString *)destinationPath
               parameters:(NSDictionary *)parameters
                 progress:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;
/**
 *  Deletes the specified object. Once deleted, there is no method to restore or undelete an object.
 *
 *  @param path    <#path description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)deleteObjectWithPath:(NSString *)path
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;
@end
