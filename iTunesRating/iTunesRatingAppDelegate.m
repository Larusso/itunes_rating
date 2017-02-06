//
//  iTunesRatingAppDelegate.m
//  iTunesRating
//
//  Created by Larusso on 31.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "iTunesRatingAppDelegate.h"
#import "TSFiveStarRating.h"
#import "TSiTunesRatingUtils.h"

@implementation iTunesRatingAppDelegate

@synthesize window;
@synthesize coverArtwork;
@synthesize titleField;
@synthesize artistField;
@synthesize ratingView;

- (void)awakeFromNib {
    [window setCollectionBehavior:NSWindowCollectionBehaviorMoveToActiveSpace];
    [window setStyleMask:NSBorderlessWindowMask];
    [window setOpaque:NO];
    NSColor *windowColor = [NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:0];
    [window setBackgroundColor:windowColor];
    [window setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey) + 1];
    NSPoint p;
    p.x = 0;
    p.y = 0;
    [window setFrameOrigin:p];

}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(receivediTunesNotification:) name:@"com.apple.iTunes.playerInfo" object:nil];
    [self initView];
}

- (void)applicationDidChangeScreenParameters:(NSNotification *)aNotification {
    NSPoint p;
    p.x = 0;
    p.y = 0;
    [window setFrameOrigin:p];
}

- (void)receivediTunesNotification:(NSNotification *)note {
    NSLog(@"receivediTunesNotification: %@", note);
    //[self updateView:[note userInfo]];
    [self initView];
}

- (void)updateView:(NSDictionary *)titleData {
    [titleField setStringValue:[titleData valueForKey:@"Name"]];
    [artistField setStringValue:[titleData valueForKey:@"Artist"]];

    NSInteger ratingValue = [[titleData valueForKey:@"Rating"] integerValue];
    BOOL isComputed = [[titleData valueForKey:@"Rating Computed"] boolValue];

    [ratingView setRating:ratingValue isComputed:isComputed];

    NSImage *coverArtworkRaw = [[NSImage alloc] initWithData:[titleData valueForKey:@"Cover"]];

    [coverArtwork setImage:coverArtworkRaw];
}

- (void)initView {
    NSString *scriptPath = [[NSBundle mainBundle] pathForResource:@"iTunesGetCurrentTitle" ofType:@"scpt" inDirectory:@"Scripts"];

    NSAppleScript *as = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:scriptPath] error:nil];

    NSAppleEventDescriptor *descriptor = [as executeAndReturnError:nil];
    NSLog(@"result == %@", descriptor);
    NSDictionary *titleData = [self transformAppleScriptReturn:descriptor];
    [self updateView:titleData];
}

- (NSDictionary *)transformAppleScriptReturn:(NSAppleEventDescriptor *)descriptor {
    NSMutableDictionary *titleData = [TSiTunesRatingUtils dictionaryFromAppleEventDescriptor:descriptor];
    return titleData;
}

- (void)ratingChanged:(NSInteger)newValue {
    NSString *scriptPath = [[NSBundle mainBundle] pathForResource:@"iTunesSetRatingToCurrentTitle" ofType:@"scpt" inDirectory:@"Scripts"];
    NSAppleScript *as = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:scriptPath] error:nil];

    if (as) {
        //init first param

        NSAppleEventDescriptor *firstParameter = [NSAppleEventDescriptor descriptorWithInt32:round(newValue)];

        // create and populate the list of parameters
        // note that the array starts at index 1
        NSAppleEventDescriptor *parameters = [NSAppleEventDescriptor listDescriptor];
        [parameters insertDescriptor:firstParameter atIndex:1];

        // create the AppleEvent target
        ProcessSerialNumber psn = {0, kCurrentProcess};
        NSAppleEventDescriptor *target = [NSAppleEventDescriptor descriptorWithDescriptorType:typeProcessSerialNumber
                                                                                        bytes:&psn
                                                                                       length:sizeof(ProcessSerialNumber)];
        // create an NSAppleEventDescriptor with the method name
        // note that the name must be lowercase (even if it is uppercase in AppleScript)
        NSAppleEventDescriptor *handler = [NSAppleEventDescriptor descriptorWithString:[@"updateRating" lowercaseString]];
        // last but not least, create the event for an AppleScript subroutine
        // set the method name and the list of parameters

        NSAppleEventDescriptor *event = [NSAppleEventDescriptor appleEventWithEventClass:kASAppleScriptSuite eventID:kASSubroutineEvent targetDescriptor:target returnID:kAutoGenerateReturnID transactionID:kAnyTransactionID];
        [event setParamDescriptor:handler forKeyword:keyASSubroutineName];
        [event setParamDescriptor:parameters forKeyword:keyDirectObject];

        [as executeAppleEvent:event error:nil];


    }


}

- (void)dealloc {
    [ratingView release];
}

@end    
