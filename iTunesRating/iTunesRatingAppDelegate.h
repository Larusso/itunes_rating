//
//  iTunesRatingAppDelegate.h
//  iTunesRating
//
//  Created by Larusso on 31.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>
#import "TSFiveStarRatingDelegate.h"


@class TSFiveStarRating;
@class TSiTunesRatingWindow;

@interface iTunesRatingAppDelegate : NSObject <NSApplicationDelegate, TSFiveStarRatingDelegate> {
@private
    NSImageView *coverArtwork;
    NSTextField *titleField;
    NSTextField *artistField;
    TSFiveStarRating *ratingView;
    TSiTunesRatingWindow *window;
}
@property (assign) IBOutlet TSiTunesRatingWindow *window;
@property (assign) IBOutlet NSImageView *coverArtwork;
@property (assign) IBOutlet NSTextField *titleField;
@property (assign) IBOutlet NSTextField *artistField;
@property (assign) IBOutlet TSFiveStarRating *ratingView;

- (void) receivediTunesNotification:(NSNotification *)note;
-(void) updateView:(NSDictionary *)titleData;
-(void) initView;
-(NSDictionary *) transformAppleScriptReturn:(NSAppleEventDescriptor *)descriptor;
@end
