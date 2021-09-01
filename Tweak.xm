#import "Tweak.h"

/**
 * Load Preferences
 */
BOOL noads;

static void reloadPrefs() {
  NSDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@PLIST_PATH] ?: [@{} mutableCopy];

  noads = [[settings objectForKey:@"noads"] ?: @(YES) boolValue];
}

%group NewsFeedAndPosts
  %hook Post
  - (bool)isHidden {  
    NSString *className = NSStringFromClass([self class]);
    if ([className isEqual:@"RedditCore.AdPost"] || [className isEqual:@"AdPost"]) {
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

  if (noads) {
    %init(NewsFeedAndPosts, CommentAdPostCellNode = objc_getClass("Reddit.CommentAdPostCellNode"));
  }
}
