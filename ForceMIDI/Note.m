//
//  Note.m
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/5/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import "Note.h"

@implementation Note

- (id)initWithLetter:(NSString *)letter octave:(Octave)octave {
    return [self initWithLetter:letter modifier:Natural octave:octave];
}

- (id)initWithLetter:(NSString *)letter modifier:(enum NoteModifier)modifier octave:(Octave)octave {
    Byte base;
    if([letter isEqualToString:@"C"]) {
        base = 12;
    } else if([letter isEqualToString:@"D"]) {
        base = 14;
    } else if([letter isEqualToString:@"E"]) {
        base = 16;
    } else if([letter isEqualToString:@"F"]) {
        base = 17;
    } else if([letter isEqualToString:@"G"]) {
        base = 19;
    } else if([letter isEqualToString:@"A"]) {
        base = 21;
    } else if([letter isEqualToString:@"B"]) {
        base = 23;
    }

    midiNumber = base + modifier + octave * 12;
    return self;
}

- (id)initWithMidiNumber:(Byte)number {
    if(self = [super init]) {
        midiNumber = number;
    }
    return self;
}

-  (Byte)midiNumber {
    return midiNumber;
}

@end
