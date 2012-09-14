OEGParseBackedModel
===================

Simple superclass for models persisted to Parse.com.

To get a nice model class instead of dealing with generic PFObjects all the time, define your model like this:

```objective-c
@interface Model : OEGParseBackedModel
@property (nonatomic) NSString *name;
@end

@implementation Model
@dynamic name;

- (id)init {
  return [super initWithClassName:@"Model"];
}

@end
```

Then use it like this:

```objective-c
Model *model = [[Model alloc] init];
model.name = @"Maverick";
[model saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
  if (succeeded) {
    NSLog(@"Model saved to Parse!");
  }
}];
```

The code is very basic but perhaps it can serve as some kind of inspiration to someone. It should check if the property is declared as readonly and not generate a setter in that case.
