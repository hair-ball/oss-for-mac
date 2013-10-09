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
    [self.loginWindowController.window setDelegate:self];
    [self.loginWindowController.window orderFrontRegardless];

    //git_flow_test

//    [self setWindow:self.loginWindowController.window];

}

#pragma mark - NSApplicationDelegate

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    if (!flag) {
        [self.loginWindowController.window orderFrontRegardless];
        return YES;
    }
    return NO;
}

#pragma mark - NSWindowDelegate

- (BOOL)windowShouldClose:(id)sender {
//    [NSApp terminate:self];
//    [sender miniaturize:nil];
    [sender setIsVisible:NO];
    return YES;
}

@end