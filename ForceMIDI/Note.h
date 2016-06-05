//
//  Note.h
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/5/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import <Foundation/Foundation.h>

enum NoteModifier {
    Flat = -1,
    Natural = 0,
    Sharp = 1
};

typedef int Octave;

@interface Note : NSObject {
    Byte midiNumber;
}

- (id)initWithLetter:(NSString *)letter octave:(Octave)octave;

- (id)initWithLetter:(NSString *)letter modifier:(enum NoteModifier)modifier octave:(Octave)octave;

- (id)initWithMidiNumber:(Byte)number;

-  (Byte)midiNumber;

@end
