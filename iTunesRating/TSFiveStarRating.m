//
//  TSFiveStarRating.m
//  iTunesRating
//
//  Created by Larusso on 03.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TSFiveStarRating.h"


@implementation TSFiveStarRating;

@synthesize delegate;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        NSTrackingArea *trackArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options:NSTrackingMouseMoved | NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways | NSTrackingInVisibleRect owner:self userInfo:nil];
        [self addTrackingArea:trackArea];
        
        starRated = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"ratingStar_rate"]];
        starNotRated = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"ratingStar_no_rate.png"]];
        starComputed = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"ratingStar_rate_computed.png"]];
        starUserRated = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"ratingStar_rate_user.png"]];
        starUserRatedEmpty = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"ratingStar_rate_empty.png"]];
        value = 0;
        isComputed = NO;
        isRatingEnabled = NO;
    }
    
    return self;        
}
#pragma mark -
#pragma mark DRAWING
- (void)drawRect:(NSRect)theRect
{
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    
    NSImage *imageToDraw = starNotRated;
    NSRect fromRect = NSZeroRect;
    NSRect drawRect = NSMakeRect(0, 0, 120, 24);
    
    if( isRatingEnabled )
    {
        
        if(userRatingValue > 0 )
        {
            [starUserRatedEmpty drawInRect: NSMakeRect(0, 0, 120, 24) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
            imageToDraw = starUserRated;
            
            NSInteger starWidth = ( ( [[NSNumber numberWithInteger: userRatingValue] floatValue] / 100 ) * 5 ) * 24;
            fromRect = NSMakeRect(0, 0, starWidth , 24);
            drawRect = fromRect;
        }
        else
        {
            imageToDraw = starUserRatedEmpty;
        }
        
    }
    else
    {
        
        if(value > 0 )
        {
            imageToDraw = (isComputed) ? starComputed : starRated;
            
            
            NSInteger starWidth = ( ( [[NSNumber numberWithInteger: value] floatValue] / 100 ) * 5 ) * 24;
            fromRect = NSMakeRect(0, 0, starWidth , 24);
            drawRect = fromRect;
        }
        
        
    }
    
    [imageToDraw drawInRect:drawRect fromRect:fromRect operation:NSCompositeSourceOver fraction:1.0];
    
    
}


#pragma mark -
#pragma mark INTERNAL METHODS
- (void)setRating:(NSInteger)ratingValue
{
    [self setRating:ratingValue isComputed:NO isUserRating:NO];
}

- (void)setUserRating:(NSInteger)ratingValue
{
    [self setRating:ratingValue isComputed:NO isUserRating:YES];
}

- (void)setRating:(NSInteger)ratingValue isComputed:(BOOL)isValueComputed
{
   [self setRating:ratingValue isComputed:isValueComputed isUserRating:NO]; 
}
- (void)setRating:(NSInteger)ratingValue isComputed:(BOOL)isValueComputed isUserRating:(BOOL)isUserValue
{
    if( isUserValue )
    {
        if( userRatingValue != ratingValue )
        {
            userRatingValue = ratingValue;
            [self setNeedsDisplay:YES];
        }
    }
    else
    {
        if( value != ratingValue)
        {
            value = ratingValue;
            isComputed = isValueComputed;
            [self setNeedsDisplay:YES];
        }
    }
    
}

- (void)measureRatedValue:(NSPoint)mouseLocation
{
    [self setUserRating:(round(mouseLocation.x / 24) * 20 )];
}

#pragma mark -
#pragma mark EVENTS
- (BOOL)acceptsFirstResponder 
{
    return YES;
}

- (void)mouseDown:(NSEvent*)theEvent
{
    NSLog(@"mouseDown");
    isNextMouseDownClick = YES;
}

- (void)mouseDragged:(NSEvent*)theEvent
{
    NSLog(@"mouseDragged");
    isNextMouseDownClick = NO;
}

- (void)mouseUp:(NSEvent*)theEvent
{
    NSLog(@"mouseUp");
    if(isNextMouseDownClick)
    {
        if(isRatingEnabled)
        {
            isRatingEnabled = NO;
            [self setRating:userRatingValue];
            if(delegate)
            {
                [[self delegate] ratingChanged:value];
            }
        }
        else
        {
            isRatingEnabled = YES;
            NSPoint mouseLoc;
            mouseLoc = [self convertPoint:[theEvent locationInWindow] fromView:nil];
            NSLog(@"Mouse location: %f %f", mouseLoc.x, mouseLoc.y );
            [self measureRatedValue:mouseLoc];
        }
        
    }
}

- (void)mouseMoved:(NSEvent*)theEvent
{
    //NSLog(@"mouseMoved");
    if(isRatingEnabled)
    {
        NSLog(@"mouseMoved");
        NSPoint mouseLoc;
        mouseLoc = [self convertPoint:[theEvent locationInWindow] fromView:nil];
        NSLog(@"Mouse location: %f %f", mouseLoc.x, mouseLoc.y );
        [self measureRatedValue:mouseLoc];
        
    }
}

- (void)mouseEntered:(NSEvent*)theEvent
{
    NSLog(@"---> mouseEntered");
}

- (void)mouseExited:(NSEvent*)theEvent
{
    NSLog(@"<--- mouseExited");
    if(isRatingEnabled)
    {
        isRatingEnabled = NO;
        [self setNeedsDisplay:YES];
    }
}

- (void)dealloc
{
    [super dealloc];
    [starRated release];
    [starNotRated release];
    [starComputed release];
}


@end
