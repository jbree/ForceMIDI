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
        [self activateStatusMenu];
    }
    return self;
}

- (void)activateStatusMenu {
    NSStatusBar *bar = [NSStatusBar systemStatusBar];

    menuItem = [bar statusItemWithLength:NSVariableStatusItemLength];
    [[menuItem button] setTitle:@"MIDI"];

    [[menuItem button] setTarget:self];
}

- (void)mouseDown:(NSEvent*)event {
    NSButton* button = [menuItem button];

    [button setBordered:![button isBordered]];
}

@end
