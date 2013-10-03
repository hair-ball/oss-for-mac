//
//  AppDelegate.m
//  OSS
//
//  Created by undancer on 13-10-3.
//  Copyright (c) 2013 undancer. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+NetworkObserver.h"
#import "LoginWindowController.h"

@interface AppDelegate ()

@property IBOutlet LoginWindowController *loginWindowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notify {

    [self startNetworkObserver];

    self.loginWindowController = [[LoginWindowController alloc] initWithWindowNibName:@"LoginWindowController"];
    [self setWindow:self.loginWindowController.window];
}

@end