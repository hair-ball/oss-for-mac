//
//  AppDelegate.m
//  OSS
//
//  Created by undancer on 13-10-3.
//  Copyright (c) 2013 undancer. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+NetworkObserver.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notify {

    [self startNetworkObserver];

}

@end