//
//  MIDIDevice.h
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/5/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Note.h"

@interface MIDIDevice : NSObject

@property (assign, readwrite) BOOL enabled;

- (void)sendCommandNoteOn:(Note *)note withVelocity:(UInt8)velocity;
- (void)sendCommandNoteOff:(Note *)note;

@end
