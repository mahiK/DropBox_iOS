//
//  ListViewController.h
//  TheAssignment


#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>
#import "ShowPhotoViewController.h"

@interface ListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DBRestClientDelegate>
@property (nonatomic, strong) DBRestClient *restClient;
@property (nonatomic, strong) NSMutableArray * imageArray;
@property (nonatomic, strong) UIImageView * cellImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) NSMutableArray * imageNameArray;
@property (nonatomic, strong) ShowPhotoViewController * showPhotoView;

@property (weak, nonatomic) IBOutlet UITableView *photoListView;
- (IBAction)backButtonPressed:(id)sender;
@end
