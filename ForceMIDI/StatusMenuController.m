//
//  StatusMenuController.m
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/5/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import "StatusMenuController.h"

#import <Cocoa/Cocoa.h>

@interface StatusMenuController() {
    NSStatusItem* menuItem;
}

@end

@implementation StatusMenuController

- (id)init {
    if(self = [super init]) {
        [self initializeStatusMenu];
    }
    return self;
}

- (void)initializeStatusMenu {
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    menuItem = [bar statusItemWithLength:NSVariableStatusItemLength];

    NSButton *button = [menuItem button];
    NSImage *offImage = [NSImage imageNamed:@"MIDI"];
    [offImage setTemplate:YES];
    NSImage *onImage = [NSImage imageNamed:@"MIDIOn"];
    [onImage setTemplate:YES];

    [button setButtonType:NSToggleButton];
    [button setTitle:@"MIDI"];
    [button setImage:offImage];
    [button setAlternateImage:onImage];

    [button setTarget:self];
    [button setAction:@selector(toggleMenuItem)];
}

- (void)toggleMenuItem {
    if([[menuItem button] state] == NSOnState) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userDidEnableForceMIDI" object:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userDidDisableForceMIDI" object:self];
    }
}

@end
