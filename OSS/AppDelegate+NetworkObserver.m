//
//  AppDelegate+NetworkObserver.m
//  OSS
//
//  Created by undancer on 13-10-3.
//  Copyright (c) 2013年 undancer. All rights reserved.
//

#import "AppDelegate+NetworkObserver.h"
#import "Reachability.h"

#define kDEFAULT_OSS_ENDPOINT_REGION @"oss.aliyuncs.com"

@implementation AppDelegate (NetworkObserver)

- (void)startNetworkObserver {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityIsChanged:) name:kReachabilityChangedNotification object:nil];

    Reachability *reachability = [Reachability reachabilityWithHostname:kDEFAULT_OSS_ENDPOINT_REGION];

//    [reachability setReachableBlock:^(Reachability* reachability){
//    }];
//    [reachability setUnreachableBlock:^(Reachability* reachability){
//    }];

    [reachability startNotifier];
}

- (void)reachabilityIsChanged:(NSNotification *)notify {
    NSLog(@"reachabilityIsChanged : %@ ", [[notify object] currentReachabilityFlags]);
    NSLog(@"reachabilityIsChanged : %@ ", [[notify object] currentReachabilityString]);
}

@end
