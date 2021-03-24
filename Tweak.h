#import <Foundation/Foundation.h>
#import <libhdev/HUtilities/HDownloadMedia.h>

#define PLIST_PATH "/var/mobile/Library/Preferences/com.haoict.redditnoadspref.plist"
#define PREF_CHANGED_NOTIF "com.haoict.redditnoadspref/PrefChanged"

@interface Post : NSObject
@end

@interface ASDisplayNode : UIView
@property(getter=isHidden) BOOL hidden;
@property BOOL neverShowPlaceholders;
@end


@interface CommentAdPostCellNode : ASDisplayNode
@end
