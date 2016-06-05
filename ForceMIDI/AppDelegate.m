//
//  AppDelegate.m
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/4/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import "AppDelegate.h"

#import "StatusMenuController.h"
#import "TouchButtons.h"

@interface AppDelegate () {
    TouchButtons* buttons;
    StatusMenuController* menu;
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    menu = [[StatusMenuController alloc] init];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
