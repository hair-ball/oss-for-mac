//
//  AppDelegate+NetworkObserver.m
//  OSS
//
//  Created by undancer on 13-10-3.
//  Copyright (c) 2013年 undancer. All rights reserved.
//

#import "AppDelegate+NetworkObserver.h"
#import "Reachability.h"

@implementation AppDelegate (NetworkObserver)

-(void)startNetworkObserver{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityIsChanged:) name:kReachabilityChangedNotification object:nil];
    
    Reachability* reachability = [Reachability reachabilityWithHostname:@"oss.aliyun.com"];

//    [reachability setReachableBlock:^(Reachability* reachability){
//    }];
//    [reachability setUnreachableBlock:^(Reachability* reachability){
//    }];
    
    [reachability startNotifier];
}

-(void)reachabilityIsChanged:(NSNotification*) notify{
    NSLog(@"reachabilityIsChanged : %@ ",[[notify object] currentReachabilityFlags]);
    NSLog(@"reachabilityIsChanged : %@ ",[[notify object] currentReachabilityString]);
}

@end
