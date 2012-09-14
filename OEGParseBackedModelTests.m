//
//  OEGParseBackedModelTests.m
//  ParseBackedModel
//
//  Created by Anders Carlsson on 2012-05-27.
//  Copyright (c) 2012 Önders et Gonas. All rights reserved.
//

#import <Parse/Parse.h>
#import "OEGParseBackedModelTests.h"
#import "OEGParseBackedModel.h"

@interface Model : OEGParseBackedModel
@property (nonatomic) NSString *name;
@property (nonatomic) NSNumber *awesomenessRating;
@property (nonatomic) NSString *URLString;
@end

@implementation Model
@dynamic name;
@dynamic awesomenessRating;
@dynamic URLString;
@end


@implementation OEGParseBackedModelTests {
  Model *model;
}

- (void)setUp {
  [super setUp];
  
  model = [[Model alloc] initWithClassName:@"Test"];
}

- (void)tearDown {
  model = nil;
  
  [super tearDown];
}

- (void)testModelGeneratesSetterForName {
  model.name = @"Test";
  STAssertEqualObjects([model.parseObject objectForKey:@"name"], @"Test", nil);
}

- (void)testModelGeneratesGetterForName {
  model.name = @"Test";
  STAssertEqualObjects(model.name, @"Test", nil);
}

- (void)testCanDoCamelCase {
  model.awesomenessRating = [NSNumber numberWithInt:1337];
  STAssertEquals(model.awesomenessRating.intValue, 1337, nil);
}

- (void)testCannotHandleCapitalizedPropertyNames {
  STAssertThrows(model.URLString = @"test test", nil);
}

@end
