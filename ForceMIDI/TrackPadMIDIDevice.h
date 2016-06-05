//
//  TrackPadMIDIDevice.h
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/5/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackPadMIDIDevice : NSObject

//- (void)setNote:(Note *)note forRegion:(int)region;

@property (assign, readwrite) BOOL enabled;

@end
