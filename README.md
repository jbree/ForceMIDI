# ForceMIDI
Use your MacBook trackpad as a MIDI controller

## Abandonware!

This was a quick hack I put together because I didn't have a MIDI controller,
and I needed to play some sweet sounding tabla samples.

The notes are hard coded to what I needed(A1, B1, C2, D2). I briefly thought
about putting more effort into completing it before moving on to other projects.

## Installation

There is no installer or pre-built version of this application. To build from
source

1) clone the repository

2) use [CocoaPods](https://cocoapods.org) to download dependencies:

```
$ pod install
```

3) Then build and run `ForceMIDI.xcworkspace` (not `*xcodeproj`) using XCode

## Usage

Creates an item in the menu bar from which you can enable the virtual MIDI
device. Look out! MIDI will be spewing out all over the place until you click
the menu item again to turn off the virtual device.

Nothing in the preferences window works.

## Dependencies
+ [M5MultitouchSupport](https://github.com/mhuusko5/M5MultitouchSupport)
+ [MIKMIDI](https://github.com/mixedinkey-opensource/MIKMIDI)
