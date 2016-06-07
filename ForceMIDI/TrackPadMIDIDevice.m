//
//  TrackPadMIDIDevice.m
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/5/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import "TrackPadMIDIDevice.h"

#import <M5MultitouchSupport.h>

#import "Finger.h"
#import "MIDIDevice.h"

@interface TrackPadMIDIDevice() {
    NSMutableDictionary* noteMap;
    NSMutableDictionary *fingers;

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
        fingers = [[NSMutableDictionary alloc] init];

        [self setNote:[[Note alloc] initWithLetter:@"A" octave:1] forRegion:BottomLeft];
        [self setNote:[[Note alloc] initWithLetter:@"B" octave:1] forRegion:BottomRight];
        [self setNote:[[Note alloc] initWithLetter:@"C" octave:2] forRegion:TopLeft];
        [self setNote:[[Note alloc] initWithLetter:@"D" octave:2] forRegion:TopRight];
    }
    return self;
}

- (void)initTrackPad {

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

- (Note *)getNoteForPosition:(NSPoint)pos {
    int region = 0;

    if(pos.x > 0.5) region += 1;
    if(pos.y > 0.5) region += 2;

    return [self getNoteForRegion:region];
}

- (void)didReceiveTouch:(M5MultitouchEvent *)event {
    for(int i = 0; i < [event.touches count]; i++) {
        M5MultitouchTouch *touch = [event.touches objectAtIndex:i];

        Finger *finger = [fingers objectForKey:[NSNumber numberWithInt:touch.identifier]];

        // if we can't find an existing finger with this id, create one
        if(finger == nil) {
            finger = [[Finger alloc] init];
            finger.identifier = [NSNumber numberWithInt:touch.identifier];
            finger.delegate = self;
            [fingers setObject:finger forKey:finger.identifier];
        }

        // send the multitouch event to the existing or newly created finger
        [finger addMultitouch:touch];
    }
}

- (void)didMoveFinger:(Finger *)finger {
    if(!_enabled) {
        return;
    }

    switch(finger.state) {
        case FingerTouch:
            finger.note = [self getNoteForPosition:finger.position];

            [midi sendCommandNoteOn:finger.note
                       withVelocity:finger.pressure];
            break;

        case FingerAftertouch:
            break;

        case FingerRelease:
            [midi sendCommandNoteOff:finger.note];
            [fingers removeObjectForKey:finger.identifier];
            break;
    }
}

@end
