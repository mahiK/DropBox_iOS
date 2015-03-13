//
//  AppDelegate.h
//  TheAssignment


#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>
#import "LogInViewController.h"
#import "CameraViewController.h"
#import "ListViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,DBSessionDelegate,DBNetworkRequestDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LogInViewController * logInView;
@property (strong, nonatomic) CameraViewController * cameraView;
@property (strong, nonatomic) ListViewController * listView;

@end
