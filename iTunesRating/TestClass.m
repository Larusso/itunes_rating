//
//  Created by larusso on 20.03.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TestClass.h"


@implementation TestClass {

}
-(TestClass *) initWithName:(NSString *)theName{
    if (self.init){
        self.name = theName;
    }

    return self;
}


-(void) setName: (NSString *) theName {
    TestClass * one = [[TestClass alloc] initWithName:@"manne"];
    TestClass * two = [[TestClass alloc] init];
    two.name = @"bla";

    NSArray *array = [[NSArray alloc] initWithObjects:one,two count:2];
    NSMutableArray *muArray = [[NSMutableArray alloc] initWithArray:array];

}

-(void)dealloc {
    [name release];
}


-(NSString *) name {
    [name retain];
    return self.name;
}

@end