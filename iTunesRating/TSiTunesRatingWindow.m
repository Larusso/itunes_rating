//
//  TSiTunesRatingWindow.m
//  iTunesRating
//
//  Created by Larusso on 16.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TSiTunesRatingWindow.h"


@implementation TSiTunesRatingWindow

- (id)init
{
    self = [super init];
    if (self) 
    {
        [self setCollectionBehavior:NSWindowCollectionBehaviorMoveToActiveSpace];
        [self setStyleMask:NSBorderlessWindowMask];
        [self setOpaque:NO];
        NSColor *windowColor = [NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:0];
        [self setBackgroundColor:windowColor];
        [self setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey)];
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (BOOL) canBecomeKeyWindow
{
    return YES;
}

- (BOOL) canBecomeMainWindow
{
    return YES;
}

@end
