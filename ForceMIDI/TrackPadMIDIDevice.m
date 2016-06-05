//
//  TrackPadMIDIDevice.m
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/5/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import "TrackPadMIDIDevice.h"

#import <CoreMIDI/CoreMIDI.h>

@interface TrackPadMIDIDevice() {
    NSMutableDictionary* noteMap;
    BOOL MIDIEnabled;

    MIDIClientRef midiClient;
    MIDIEndpointRef midiSource;
}

@end

@implementation TrackPadMIDIDevice

- (id)init {
    if(self = [super init]) {
        noteMap = [[NSMutableDictionary alloc] init];
        [self setNote:[[Note alloc] initWithLetter:@"A" octave:1] forRegion:BottomLeft];
        [self setNote:[[Note alloc] initWithLetter:@"B" octave:1] forRegion:BottomRight];
        [self setNote:[[Note alloc] initWithLetter:@"C" octave:2] forRegion:TopLeft];
        [self setNote:[[Note alloc] initWithLetter:@"D" octave:2] forRegion:TopRight];
    }
    return self;
}

- (void)setMIDIEnabled:(BOOL)enabled {
    if(enabled == MIDIEnabled) {
        return;
    }

    if(enabled) {
        MIDIClientCreate((__bridge CFStringRef _Nonnull)@"ForceMIDI", NULL, NULL, &midiClient);
        MIDISourceCreate(midiClient, (__bridge CFStringRef _Nonnull)@"ForceMIDI", &midiSource);
        MIDIEnabled = YES;
    } else {
        if(MIDIEnabled) {
            MIDIClientDispose(midiClient);
        }
    }

}

- (void)setNote:(Note *)note forRegion:(enum Region)region {
    [noteMap setObject:note forKey:[NSNumber numberWithInt:region]];
}

- (Note*)getNoteForRegion:(enum Region)region {
    return [noteMap objectForKey:[NSNumber numberWithInt:region]];
}

@end
