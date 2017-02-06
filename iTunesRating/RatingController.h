//
//  RatingController.h
//  iTunesRating
//
//  Created by Larusso on 02.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface RatingController : NSViewController {
    
    NSButton *starOne;
    NSButton *starTwo;
    NSButton *starThree;
    NSButton *starFour;
    NSButton *starFive;

}
@property (assign) IBOutlet NSButton *starOne;
@property (assign) IBOutlet NSButton *starTwo;
@property (assign) IBOutlet NSButton *starThree;
@property (assign) IBOutlet NSButton *starFour;
@property (assign) IBOutlet NSButton *starFive;

- (IBAction)mouseOver:(id)sender;


@end
