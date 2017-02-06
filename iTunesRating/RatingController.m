//
//  RatingController.m
//  iTunesRating
//
//  Created by Larusso on 02.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RatingController.h"


@implementation RatingController
@synthesize starOne;
@synthesize starTwo;
@synthesize starThree;
@synthesize starFour;
@synthesize starFive;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


- (IBAction)action:(id)sender {
}

- (IBAction)mouseOver:(id)sender {
}
@end
