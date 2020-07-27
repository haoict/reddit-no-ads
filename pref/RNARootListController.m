#include "RNARootListController.h"

#define TWEAK_TITLE "Reddit No Ads"
#define TINT_COLOR "#1fc9c9"
#define BUNDLE_NAME "RNAPref"

@implementation RNARootListController
- (id)init {
  self = [super init];
  if (self) {
    self.tintColorHex = @TINT_COLOR;
    self.bundlePath = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@.bundle", @BUNDLE_NAME];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[self localizedItem:@"APPLY"] style:UIBarButtonItemStylePlain target:self action:@selector(apply)];;
  }
  return self;
}

- (void)apply {
  [HCommon killProcess:@"Reddit" viewController:self alertTitle:@TWEAK_TITLE message:[self localizedItem:@"DO_YOU_REALLY_WANT_TO_KILL_REDDIT"] confirmActionLabel:[self localizedItem:@"CONFIRM"] cancelActionLabel:[self localizedItem:@"CANCEL"]];
}

@end
