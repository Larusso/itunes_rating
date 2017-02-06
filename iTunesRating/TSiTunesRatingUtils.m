//
//  TSiTunesRatingUtils.m
//  iTunesRating
//
//  Created by Larusso on 13.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TSiTunesRatingUtils.h"


@implementation TSiTunesRatingUtils

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

+ (NSString *) convertAppleKeyToiTunesKey:(NSString *)theAppleKey
{
    NSString *iTunesKey;
    NSRange checkRange = [theAppleKey rangeOfString:@"track_"];
    
    
    if( checkRange.location == 0 )
    {
        iTunesKey = [[theAppleKey stringByReplacingOccurrencesOfString:@"track_" withString:@""] stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    }
    else
    {
        iTunesKey = theAppleKey;
    }
    return iTunesKey;
    
}

+ (id)objectFromAppleEventDescriptor:(NSAppleEventDescriptor *)descriptor {
    switch ([descriptor descriptorType]) {
        case typeChar:
        case typeUnicodeText:
            return [descriptor stringValue];
        case typeAEList:
            return [TSiTunesRatingUtils arrayFromAppleEventDescriptor:descriptor];
        case typeAERecord:
            return [TSiTunesRatingUtils dictionaryFromAppleEventDescriptor:descriptor];
            
        case typeBoolean:
            return [NSNumber numberWithBool:(BOOL)[descriptor booleanValue]];
        case typeTrue:
            return [NSNumber numberWithBool:YES];
        case typeFalse:
            return [NSNumber numberWithBool:NO];
        case typeType:
            return [NSNumber numberWithUnsignedLong:(unsigned long)[descriptor typeCodeValue]];
        case typeEnumerated:
            return [NSNumber numberWithUnsignedLong:(unsigned long)[descriptor enumCodeValue]];
        case typeNull:
            return [NSNull null];
            
        case typeSInt16:
            return [NSNumber numberWithInt:(short)[descriptor int32Value]];
        case typeSInt32:
            return [NSNumber numberWithInt:(int)[descriptor int32Value]];
        case typeUInt32:
            return [NSNumber numberWithLong:(unsigned int)[descriptor int32Value]];
        case typeSInt64:
            return [NSNumber numberWithLong:(long)[descriptor int32Value]];
            //      case typeIEEE32BitFloatingPoint:
            //          return [NSNumber numberWithBytes:[[descriptor data] bytes] objCType:@encode(float)];
            //      case typeIEEE64BitFloatingPoint:
            //          return [NSNumber numberWithBytes:[[descriptor data] bytes] objCType:@encode(double)];
            //      case type128BitFloatingPoint:
            //      case typeDecimalStruct:
    }
    
    return [descriptor data];
}


+ (NSMutableArray *)arrayFromAppleEventDescriptor:(NSAppleEventDescriptor *)descriptor 
{ 
    NSInteger count = [descriptor numberOfItems]; 
    unsigned int i = 1; 
    NSMutableArray *myList = [NSMutableArray arrayWithCapacity:count]; 
    
    for (i = 1; i <= count; i++ ) { 
        id value = [TSiTunesRatingUtils objectFromAppleEventDescriptor:[descriptor descriptorAtIndex:i]]; 
        if (value) [myList addObject:value]; 
    } 
    
    return myList; 
} 


+ (NSMutableDictionary *)dictionaryFromAppleEventDescriptor:(NSAppleEventDescriptor *)descriptor 
{ 
    if (![descriptor numberOfItems]) return nil; 
    descriptor = [descriptor descriptorAtIndex:1]; 
    NSInteger count = [descriptor numberOfItems]; 
    unsigned int i = 1; 
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:count]; 
    
    for (i = 1; i <= count; i += 2 ) { 
        NSString *key = [[descriptor descriptorAtIndex:i] stringValue]; 
        id value = [TSiTunesRatingUtils objectFromAppleEventDescriptor:[descriptor descriptorAtIndex:(i + 1)]]; 
        if (key && value)
        {
            NSLog(@"key before: %@", key);
            key = [TSiTunesRatingUtils convertAppleKeyToiTunesKey:key];
            NSLog(@"key after: %@", key);
            [dict setObject:value forKey:key];
        }; 
    } 
    
    return dict; 
} 

@end
