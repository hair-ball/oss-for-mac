//
//  AFOSSClientTest.m
//  oss-for-mac
//
//  Created by di wu on 10/9/13.
//  Copyright (c) 2013 di wu. All rights reserved.
//


#import "Kiwi.h"
#import "AFOSSClient.h"
SPEC_BEGIN(AFOSSClientSpec)
describe(@"AFNetwork OSS Client", ^{
    
    describe(@"Buckets API", ^{
        
        __block  AFOSSClient *client = nil;
        beforeAll(^{
            client = [[AFOSSClient alloc] initWithAccessKeyID:@"" secret:@""];
            
            
        });
        
        describe(@"Create Bucket", ^{
            
        });
        
        describe(@"Get Bucket", ^{
            
        });
        
        describe(@"List Buckets", ^{
            it(@"should get all list without error", ^{
                [client getBucketsWithSuccess:^(id response){
                    [theValue(response) isFault];
                } failure:^(NSError *error){
                    [theValue(error) isFault];
                }];
            });
        });
        
        describe(@"Delete Bucket", ^{
            
        });
        
        describe(@"Modify Bucket permission", ^{
            
        });
        
        describe(@"Get Bucket permission", ^{
            
        });
        
    });
    
    describe(@"Object API", ^{
        
        describe(@"Upload Object", ^{
            
        });
        
        describe(@"View Object", ^{
            
        });
        
        describe(@"List Objects", ^{
            
        });
        
        describe(@"Delete Object", ^{
            
        });
        
        describe(@"Delete Objects", ^{
            
        });
    });
    
    
});

SPEC_END