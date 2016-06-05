//
//  TrackPadMIDIDevice.h
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/5/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Note.h"

enum Region {
    TopLeft = 0,
    TopRight = 1,
    BottomLeft = 2,
    BottomRight = 3
};

@interface TrackPadMIDIDevice : NSObject

- (void)setNote:(Note *)note forRegion:(enum Region)region;

- (void)setMIDIEnabled:(BOOL)enabled;

@end
