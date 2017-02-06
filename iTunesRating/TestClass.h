//
//  Created by larusso on 20.03.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface TestClass : NSObject  {
    NSString *name;
}

-(TestClass *) initWithName:(NSString *)theName;

-(void) setName: (NSString *) theName;
-(NSString *) name;

@end