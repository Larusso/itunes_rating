//
//  TSiTunesRatingUtils.h
//  iTunesRating
//
//  Created by Larusso on 13.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TSiTunesRatingUtils : NSObject {
@private
    
}

+(NSString *) convertAppleKeyToiTunesKey:(NSString *)theAppleKey;
+ (NSMutableDictionary *)dictionaryFromAppleEventDescriptor:(NSAppleEventDescriptor *)descriptor;
+ (NSMutableArray *)arrayFromAppleEventDescriptor:(NSAppleEventDescriptor *)descriptor;
+ (id)objectFromAppleEventDescriptor:(NSAppleEventDescriptor *)descriptor;
@end
