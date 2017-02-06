//
//  TSFiveStarRating.h
//  iTunesRating
//
//  Created by Larusso on 03.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TSFiveStarRatingDelegate.h"

@interface TSFiveStarRating : NSView {
@private
    NSInteger value;
    NSInteger userRatingValue;
    
    BOOL isComputed;
    
    NSImage *starNotRated;
    NSImage *starComputed;
    NSImage *starRated;
    NSImage *starUserRated;
    NSImage *starUserRatedEmpty;
    
    BOOL isRatingEnabled;
    BOOL isNextMouseDownClick;
    
    NSObject<TSFiveStarRatingDelegate> *delegate;
}

@property (assign) IBOutlet NSObject<TSFiveStarRatingDelegate> *delegate;

- (void)setRating:(NSInteger)ratingValue;
- (void)setUserRating:(NSInteger)ratingValue;
- (void)setRating:(NSInteger)ratingValue isComputed:(BOOL)isValueComputed;
- (void)setRating:(NSInteger)ratingValue isComputed:(BOOL)isValueComputed isUserRating:(BOOL)isUserValue;

- (void)mouseDown:(NSEvent*)theEvent;
- (void)mouseDragged:(NSEvent*)theEvent;
- (void)mouseUp:(NSEvent*)theEvent;
- (void)mouseMoved:(NSEvent*)theEvent;
- (void)mouseEntered:(NSEvent*)theEvent;
- (void)mouseExited:(NSEvent*)theEvent;
- (void)measureRatedValue:(NSPoint)mouseLocation;


@end
