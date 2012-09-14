//
//  OEGParseBackedModel.m
//  ParseBackedModel
//
//  Created by Anders Carlsson on 2012-05-27.
//  Copyright (c) 2012 Önders et Gonas. All rights reserved.
//

#import <objc/runtime.h>
#import "OEGParseBackedModel.h"

@implementation OEGParseBackedModel

@synthesize parseObject;

- (id)initWithPFObject:(PFObject *)pfObject {
  if (self = [super init]) {
    self.parseObject = pfObject;
  }
  
  return self;
}

- (id)initWithClassName:(NSString *)className {
  return [self initWithPFObject:[[PFObject alloc] initWithClassName:className]];
}

- (void)dealloc {
  self.parseObject = nil;
}


#pragma mark - Dynamic properties

+ (BOOL)resolveInstanceMethod:(SEL)sel {
  const char *selName = sel_getName(sel);
  
  BOOL setter = NO;
  NSString *selectorName = NSStringFromSelector(sel);
  NSString *propertyName;
  
  // Setter or getter?
  if ([selectorName hasPrefix:@"set"]) {
    setter = YES;
    propertyName = [NSString stringWithFormat:@"%c%s", tolower(selName[3]), (selName + 4)];
  } else {
    propertyName = selectorName;
  }
  
  propertyName = [propertyName stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":"]];
  
  objc_property_t property = class_getProperty(self, [propertyName UTF8String]);
  if (property != NULL) {
    if (setter) {
      void (^setterBlock)(id, id) = ^(id _self, id newValue) {
        [((OEGParseBackedModel *)_self).parseObject setObject:newValue forKey:propertyName];
      };
      IMP setterIMP = imp_implementationWithBlock((__bridge void *)setterBlock);
      class_addMethod(self, sel, setterIMP, "v@:@");
    } else {
      id (^getterBlock)(id) = ^(id _self) {
        return [((OEGParseBackedModel *)_self).parseObject objectForKey:propertyName];
      };
      IMP getterIMP = imp_implementationWithBlock((__bridge void *)getterBlock);
      class_addMethod(self, sel, getterIMP, "@@:");
    }
    return YES;
  }
  
  return NO;
}


#pragma mark - Some other forwarding

- (NSDate *)createdAt {
  return parseObject.createdAt;
}

- (NSDate *)updatedAt {
  return parseObject.updatedAt;
}

- (void)saveInBackgroundWithBlock:(void(^)(BOOL succeeded, NSError *error))block {
  [self.parseObject saveInBackgroundWithBlock:block];
}

@end
