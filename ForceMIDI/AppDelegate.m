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
    TrackPadMIDIDevice* trackpad;

    NSStatusItem* statusItem;
    NSMenu *menu;
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    trackpad = [[TrackPadMIDIDevice alloc] init];

    [self initializeStatusMenu];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [trackpad setEnabled:NO];
}

- (void)enableTrackPadMIDI {
    NSButton *button = [statusItem button];

    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [trackpad setEnabled:YES];
    });

    // turn this into a toggle button so that the next click will disable trackpad midi
    [button setButtonType:NSToggleButton];
    [button setState:NSOnState];

    // and disable the menu
    [statusItem setMenu:nil];
}

- (void)disableTrackPadMIDI {

    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [trackpad setEnabled:NO];
    });

    [statusItem setMenu:menu];

    NSButton *button = [statusItem button];
    [button setButtonType:NSMomentaryLightButton];
    [button setButtonType:NSOffState];

}

- (void)initializeStatusMenu {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];

    NSImage *offImage = [NSImage imageNamed:@"MIDI"];
    NSImage *onImage = [NSImage imageNamed:@"MIDIOn"];

    [offImage setTemplate:YES];
    [onImage setTemplate:YES];

    NSButton *button = [statusItem button];
    [button setTitle:@"MIDI"];
    [button setImage:offImage];
    [button setAlternateImage:onImage];

    // set up target/action for disabling midi
    [button setTarget:self];
    [button setAction:@selector(disableTrackPadMIDI)];

    // create the status item menu and its items
    menu = [[NSMenu alloc] initWithTitle:@""];

    NSMenuItem *enableItem = [[NSMenuItem alloc] initWithTitle:@"Enable"
                                                        action:@selector(enableTrackPadMIDI)
                                                 keyEquivalent:@""];

    NSMenuItem *preferencesItem = [[NSMenuItem alloc] initWithTitle:@"Preferences…"
                                                             action:@selector(openPreferences)
                                                      keyEquivalent:@""];

    NSMenuItem *quitItem = [[NSMenuItem alloc] initWithTitle:@"Quit ForceMIDI"
                                                      action:@selector(quit)
                                               keyEquivalent:@""];

    // add the items to the status menu
    [menu addItem:enableItem];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:preferencesItem];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:quitItem];

    [statusItem setMenu:menu];
}

- (void)openPreferences {
    NSLog(@"Open prefs");
}

- (void)quit {
    [NSApp terminate:self];
}


@end
