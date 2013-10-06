#import "Kiwi.h"
#import "AFOSSClient.h"
SPEC_BEGIN(MathSpec)

describe(@"Math", ^{
    it(@"is pretty cool", ^{
        NSUInteger a = 16;
        NSUInteger b = 26;
        [[theValue(a + b) should] equal:theValue(42)];
    });
});

describe(@"AFNetwork OSS Client", ^{
    
    describe(@"Buckets API", ^{
        
        __block  AFOSSClient *client = nil;
        beforeAll(^{
            client = [[AFOSSClient alloc] initWithAccessKeyID:@"aJiDhiCWJDNx5TRO" secret:@"nBjSnMOIoTomngTEtgwDv3rBnQrKDg"];
        
            
        });
        
        describe(@"Create Bucket", ^{
            
        });
        
        describe(@"Get Bucket", ^{
            
        });
        
        describe(@"List Buckets", ^{
            it(@"should get all list without error", ^{
                [client getBucketsWithSuccess:^(id response){
                    [theValue(response) isNullMock];
                } failure:^(NSError *error){
                    
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