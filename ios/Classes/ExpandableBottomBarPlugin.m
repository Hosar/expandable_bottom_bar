#import "ExpandableBottomBarPlugin.h"
#import <expandable_bottom_bar/expandable_bottom_bar-Swift.h>

@implementation ExpandableBottomBarPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftExpandableBottomBarPlugin registerWithRegistrar:registrar];
}
@end
