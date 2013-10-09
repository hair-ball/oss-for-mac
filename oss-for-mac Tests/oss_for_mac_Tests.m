//
//  AFOSSClientTest.m
//  oss-for-mac
//
//  Created by di wu on 10/9/13.
//  Copyright (c) 2013 di wu. All rights reserved.
//
#import "Kiwi.h"
SPEC_BEGIN(MathSpec)

describe(@"Math", ^{
    it(@"is pretty cool", ^{
        NSUInteger a = 16;
        NSUInteger b = 26;
        [[theValue(a + b) should] equal:theValue(42)];
    });
});

SPEC_END