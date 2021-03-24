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
    if ([NSStringFromClass([self classForCoder]) isEqual:@"AdPost"]) {
      return 1;
    }
    return %orig;
  }
  %end

  %hook CommentAdPostCellNode
    - (CommentAdPostCellNode *)initWithViewContext:(id)arg1 adPost:(id)arg2 delegate:(id)arg3 {
      // return nil makes the first normal comment disappeared
      CommentAdPostCellNode *orig = %orig(nil, nil, nil);
      // the best I can do right now is hide the cell because I can't find a way to set its height to 0.
      // it's still showing empty placeholder for ads though. I might need to investigate futher.
      orig.hidden = TRUE;
      return orig;
    }
  %end
%end

%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) reloadPrefs, CFSTR(PREF_CHANGED_NOTIF), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
  reloadPrefs();

  if (noads) {
    %init(NewsFeedAndPosts);
  }
}
