//
//  AppDelegate
//  PhotoPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, strong) IBOutlet UINavigationController *navController;
@end


@implementation AppDelegate;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    _window = [[UIWindow alloc] initWithFrame:screenBounds];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
}

@end
