//
//  OEGParseBackedModel.h
//  ParseBackedModel
//
//  Created by Anders Carlsson on 2012-05-27.
//  Copyright (c) 2012 Önders et Gonas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface OEGParseBackedModel : NSObject

@property (strong) PFObject *parseObject;

- (id)initWithClassName:(NSString *)className;
- (id)initWithPFObject:(PFObject *)pfObject;

- (NSDate *)createdAt;
- (NSDate *)updatedAt;
- (void)saveInBackgroundWithBlock:(void(^)(BOOL succeeded, NSError *error))block;

@end
