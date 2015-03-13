//
//  ShowPhotoViewController.h
//  TheAssignment


#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>

@interface ShowPhotoViewController : UIViewController

@property (nonatomic,strong) NSString * imageName;
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIImage * photoImage;

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)sharePressed:(id)sender;
- (IBAction)applyFilterPressed:(id)sender;

@end
