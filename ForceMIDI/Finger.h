//
//  Finger.h
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/6/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <M5MultitouchSupport.h>

#import "Note.h"

enum FingerState {
    FingerTouch,
    FingerAftertouch,
    FingerRelease
};

@interface Finger : NSObject

- (void)addMultitouch:(M5MultitouchTouch *)touch;

@property (retain, readwrite) Note* note;

@property (assign, readwrite) id delegate;

@property (assign, readonly) enum FingerState state;

@property (readonly) NSPoint position;

@property (readonly) NSPoint initialPosition;

@property (readonly) float pressure;

@property (retain, readwrite) NSNumber* identifier;

@end


@protocol FingerDelegate <NSObject>

- (void)didMoveFinger:(Finger *)finger;

@end
