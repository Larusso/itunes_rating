//
//  ITSiFiveStarRatingDelegate.h
//  iTunesRating
//
//  Created by Larusso on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TSFiveStarRatingDelegate <NSObject>

- (void) ratingChanged:(NSInteger)newValue;

@end
