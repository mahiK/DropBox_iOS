//
//  LogInViewController.h
//  TheAssignment


#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@interface LogInViewController : UIViewController<DBRestClientDelegate>
@property(nonatomic,strong) DBRestClient * client;

- (IBAction)logInWithDropboxButtonPressed:(id)sender;
@end
