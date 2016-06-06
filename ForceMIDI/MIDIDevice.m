//
//  MIDIDevice.m
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/5/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import "MIDIDevice.h"

#import <CoreMIDI/CoreMIDI.h>

enum MIDICommand {
    NoteOn = 0x90,
    NoteOff = 0x80
};

@interface MIDIDevice() {
    MIDIClientRef midiClient;
    MIDIEndpointRef midiSource;
}

@end

@implementation MIDIDevice

@synthesize enabled = _enabled;

- (void)setEnabled:(BOOL)enabled {
    if(enabled == _enabled) {
        return;
    }

    if(enabled) {
        // set up midi virtual device
        MIDIClientCreate((__bridge CFStringRef _Nonnull)@"ForceMIDI", NULL, NULL, &midiClient);
        MIDISourceCreate(midiClient, (__bridge CFStringRef _Nonnull)@"ForceMIDI", &midiSource);

        _enabled = YES;
    } else {
        //TODO send note off for all
        // if we were previously enabled, but no longer will be...
        if(_enabled) {
            // remove midi virtual device
            MIDIClientDispose(midiClient);
        }
        _enabled = NO;
    }
}

- (BOOL)enabled {
    return _enabled;
}

- (void)sendCommandNoteOn:(Note *)note withVelocity:(UInt8)velocity {
    [self sendCommand:NoteOn data1:[note midiNumber] data2:velocity];
}

- (void)sendCommandNoteOff:(Note *)note {
    [self sendCommand:NoteOff data1:[note midiNumber] data2:0x00];
}

- (void)sendCommand:(enum MIDICommand)c data1:(UInt8)d1 data2:(UInt8)d2 {
    NSArray *command = [NSArray arrayWithObjects:[NSNumber numberWithUnsignedInt:c],
                                                 [NSNumber numberWithUnsignedInt:d1],
                                                 [NSNumber numberWithUnsignedInt:d2],
                                                 nil];

    [self sendData: command];
}

- (void)sendData: (NSArray *)data {
    Byte *array = malloc(sizeof(Byte) * [data count]);
    for (int i = 0; i < [data count]; i++) {
        NSNumber *number = [data objectAtIndex:i];

        array[i] = [number unsignedIntValue];
    }

    char buffer[1024];
    MIDIPacketList *packets = (MIDIPacketList *)buffer;

    MIDIPacket *packet = MIDIPacketListInit(packets);
    packet = MIDIPacketListAdd(packets, 1024, packet, 0, [data count], array);

    MIDIReceived(midiSource, packets);
    
    free(array);
}





@end
