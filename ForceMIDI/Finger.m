//
//  Finger.m
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/6/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import "Finger.h"

@implementation Finger

@synthesize note = _note;

@synthesize delegate = _delegate;

@synthesize state = _state;

@synthesize position = _position;

@synthesize initialPosition = _initialPosition;

@synthesize identifier = _identifier;

@synthesize pressure = _pressure;

BOOL first = YES;

- (void)addMultitouch:(M5MultitouchTouch *)touch {
    if(first) {
        first = NO;
        return;
    }

    switch(touch.state) {
        case M5MultitouchTouchStateStarting:
            _state = FingerTouch;
            _position = _initialPosition = NSMakePoint(touch.posX, touch.posY);
            _pressure = 20 + touch.size * 70;
            _pressure = _pressure > 127 ? 127 : _pressure;
            [self.delegate didMoveFinger:self];
            break;
        case M5MultitouchTouchStateLeaving:
            _state = FingerRelease;
            [self.delegate didMoveFinger:self];
        default:
            break;
    }
}



@end
