//
//  NoteTest.m
//  ForceMIDI
//
//  Created by Joshua Breeden on 6/5/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Note.h"

@interface NoteTest : XCTestCase

@end

@implementation NoteTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNatural {
    Note* n;

    // bottom of range
    n = [[Note alloc] initWithLetter:@"A" modifier:Natural octave:0];
    XCTAssert([n midiNumber] == 21);

    n = [[Note alloc] initWithLetter:@"C" modifier:Natural octave:1];
    XCTAssert([n midiNumber] == 24);

    n = [[Note alloc] initWithLetter:@"F" modifier:Natural octave:6];
    XCTAssert([n midiNumber] == 89);

    n = [[Note alloc] initWithLetter:@"A" modifier:Natural octave:4];
    XCTAssert([n midiNumber] == 69);

    // top of range
    n = [[Note alloc] initWithLetter:@"C" modifier:Natural octave:8];
    XCTAssert([n midiNumber] == 108);
}

- (void)testSharp {
    Note* n;

    // bottom of range
    n = [[Note alloc] initWithLetter:@"A" modifier:Sharp octave:0];
    XCTAssert([n midiNumber] == 22);

    n = [[Note alloc] initWithLetter:@"C" modifier:Sharp octave:1];
    XCTAssert([n midiNumber] == 25);

    n = [[Note alloc] initWithLetter:@"F" modifier:Sharp octave:6];
    XCTAssert([n midiNumber] == 90);

    n = [[Note alloc] initWithLetter:@"A" modifier:Sharp octave:4];
    XCTAssert([n midiNumber] == 70);

    // top of range
    n = [[Note alloc] initWithLetter:@"B" modifier:Sharp octave:7];
    XCTAssert([n midiNumber] == 108);
}

- (void)testFlat {
    Note* n;

    // bottom of range
    n = [[Note alloc] initWithLetter:@"B" modifier:Flat octave:0];
    XCTAssert([n midiNumber] == 22);

    n = [[Note alloc] initWithLetter:@"C" modifier:Flat octave:1];
    XCTAssert([n midiNumber] == 23);

    n = [[Note alloc] initWithLetter:@"F" modifier:Flat octave:6];
    XCTAssert([n midiNumber] == 88);

    n = [[Note alloc] initWithLetter:@"A" modifier:Flat octave:4];
    XCTAssert([n midiNumber] == 68);

    // top of range
    n = [[Note alloc] initWithLetter:@"B" modifier:Flat octave:7];
    XCTAssert([n midiNumber] == 106);
}

@end
