@interface Post : NSObject
@end

%hook Post
- (bool)isHidden {  
  if([NSStringFromClass([self classForCoder]) isEqual:@"AdPost"]){
    return 1;
  }
  return %orig;
}
%end

