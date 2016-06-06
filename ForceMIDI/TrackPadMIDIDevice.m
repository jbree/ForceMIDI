//
//  TrackPadMIDIDevice.m
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/5/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import "TrackPadMIDIDevice.h"

#import <M5MultitouchSupport.h>

#import "MIDIDevice.h"

@interface TrackPadMIDIDevice() {
    NSMutableDictionary* noteMap;
    NSMutableDictionary* taps;

    M5MultitouchListener* mtListener;
    MIDIDevice *midi;
}

@end

@implementation TrackPadMIDIDevice

@synthesize enabled = _enabled;

- (id)init {
    if(self = [super init]) {
        midi    = [[MIDIDevice alloc] init];
        noteMap = [[NSMutableDictionary alloc] init];
        taps    = [[NSMutableDictionary alloc] init];
        [self setNote:[[Note alloc] initWithLetter:@"A" octave:1] forRegion:BottomLeft];
        [self setNote:[[Note alloc] initWithLetter:@"B" octave:1] forRegion:BottomRight];
        [self setNote:[[Note alloc] initWithLetter:@"C" octave:2] forRegion:TopLeft];
        [self setNote:[[Note alloc] initWithLetter:@"D" octave:2] forRegion:TopRight];
    }
    return self;
}

- (void)initTrackPad {

}

- (void)didReceiveTouch:(M5MultitouchEvent *)event {
    for(int i = 0; i < [event.touches count]; i++) {
        M5MultitouchTouch *touch = [event.touches objectAtIndex:i];
        int q = 0;
        int vel = touch.size * 100;
        vel = vel > 127 ? 127 : vel;

        if(touch.posX > 0.5) q += 1;
        if(touch.posY > 0.5) q += 2;

        if(touch.state == M5MultitouchTouchStateStarting) {
            Note *currentNote = [noteMap objectForKey:[NSNumber numberWithInt:q]];
            [midi sendCommandNoteOn:currentNote
                       withVelocity:vel];

            [taps setObject:currentNote
                     forKey:[NSNumber numberWithInt:touch.identifier]];
        }
        if(touch.state == M5MultitouchTouchStateLeaving) {
            NSNumber* currentTap = [NSNumber numberWithInt:touch.identifier];
            Note *currentNote = [taps objectForKey:currentTap];

            [midi sendCommandNoteOff:currentNote];
            [taps removeObjectForKey:currentTap];
        }
    }
}

- (void)setEnabled:(BOOL)enabled {
    if(enabled == _enabled) {
        return;
    }

    if(enabled) {
        [midi setEnabled:YES];
        mtListener = [[M5MultitouchManager sharedManager] addListenerWithTarget:self selector:@selector(didReceiveTouch:)];
        _enabled = YES;
    } else {
        // if we were previously enabled, but no longer are...
        if(_enabled) {
            // remove midi virtual device
            [midi setEnabled:NO];

            // remove trackpad listener
            if(mtListener) {
                [[M5MultitouchManager sharedManager] removeListener:mtListener];
                mtListener = nil;
            }
        }
        _enabled = NO;
    }
}

- (BOOL)enabled {
    return _enabled;
}

- (void)setNote:(Note *)note forRegion:(enum Region)region {
    [noteMap setObject:note forKey:[NSNumber numberWithInt:region]];
}

- (Note*)getNoteForRegion:(enum Region)region {
    return [noteMap objectForKey:[NSNumber numberWithInt:region]];
}

@end
