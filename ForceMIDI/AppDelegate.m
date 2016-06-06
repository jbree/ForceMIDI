//
//  AppDelegate.m
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/4/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import "AppDelegate.h"

#import "StatusMenuController.h"
#import "TrackPadMIDIDevice.h"

@interface AppDelegate () {
    StatusMenuController* menu;
    TrackPadMIDIDevice* trackpad;
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    menu = [[StatusMenuController alloc] init];
    trackpad = [[TrackPadMIDIDevice alloc] init];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enableTrackPadMIDI)
                                                 name:@"userDidEnableForceMIDI" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disableTrackPadMIDI)
                                                 name:@"userDidDisableForceMIDI" object:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)enableTrackPadMIDI {
    [trackpad setEnabled:YES];
}

- (void)disableTrackPadMIDI {
    [trackpad setEnabled:NO];
}




@end
