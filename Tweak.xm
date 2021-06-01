#import "Tweak.h"

/**
 * Load Preferences
 */
BOOL noads;

static void reloadPrefs() {
  NSDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@PLIST_PATH] ?: [@{} mutableCopy];

  noads = [[settings objectForKey:@"noads"] ?: @(YES) boolValue];
}

static void checkAppVersion() {
  NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
  if ([version compare:@"2021.19.0" options:NSNumericSearch] == NSOrderedAscending) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      dispatch_async(dispatch_get_main_queue(), ^{
        [HCommon showAlertMessage:@"Your current version of Reddit is not supported, please go to App Store and update it (>=2021.19.0)" withTitle:@"Reddit No Ads" viewController:nil];
      });
    });
  }
}

%group NewsFeedAndPosts
  %hook Post
  - (bool)isHidden {  
    if ([NSStringFromClass([self classForCoder]) isEqual:@"AdPost"]) {
      return 1;
    }
    return %orig;
  }
  %end

  %hook CommentAdPostCellNode
    - (id)initWithViewContext:(id)arg1 adPost:(id)arg2 delegate:(id)arg3 {
      return nil;
    }
  %end
%end

%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) reloadPrefs, CFSTR(PREF_CHANGED_NOTIF), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
  reloadPrefs();

  checkAppVersion();

  if (noads) {
    %init(NewsFeedAndPosts, CommentAdPostCellNode = objc_getClass("Reddit.CommentAdPostCellNode"));
  }
}
