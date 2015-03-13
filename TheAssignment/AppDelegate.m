//
//  AppDelegate.m
//  TheAssignment

#import "AppDelegate.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSString *dropBoxAppKey = @"fdgp4j7975vmxzm";
    NSString *dropBoxAppSecret = @"iuobk26fjgak65r";
    NSString *root = kDBRootDropbox;
    DBSession* session =
    [[DBSession alloc] initWithAppKey:dropBoxAppKey appSecret:dropBoxAppSecret root:root];
    session.delegate = self;
    [DBSession setSharedSession:session];
    
    [DBRequest setNetworkRequestDelegate:self];
    
    self.logInView = [[LogInViewController alloc]initWithNibName:@"LogInViewController" bundle:nil];
    self.window.rootViewController = self.logInView;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - DBSessionDelegate methods
- (void)sessionDidReceiveAuthorizationFailure:(DBSession*)session userId:(NSString *)userId
{
    [[[UIAlertView alloc] initWithTitle:@"Dropbox Session Ended" message:@"Do you want to relink?" delegate:self
                      cancelButtonTitle:@"Cancel" otherButtonTitles:@"Relink", nil] show];
}


- (void)networkRequestStarted{
    
}
- (void)networkRequestStopped{
    
}
#pragma mark UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)index
{
    if (index != alertView.cancelButtonIndex) {
        // [[DBSession sharedSession] linkFromController:[self.navigationController visibleViewController]];
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    if ([[DBSession sharedSession] handleOpenURL:url]) {
        
        NSString *urlString = [url absoluteString];
        if(![urlString isEqualToString:@"db-fdgp4j7975vmxzm://1/cancel"])
        {
            if ([[DBSession sharedSession] isLinked]) {
                NSLog(@"App linked successfully!");
                self.cameraView = [[CameraViewController alloc]initWithNibName:@"CameraViewController" bundle:nil];
                self.window.rootViewController = self.cameraView;
            }
        }
        
        return YES;
    }
    // Add whatever other url handling code your app requires here
    return NO;
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
