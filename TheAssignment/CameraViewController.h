//
//  CameraViewController.h
//  TheAssignment
//


#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>
#import <CoreLocation/CoreLocation.h>
#import "ListViewController.h"
#import "MapViewController.h"


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@interface CameraViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,DBRestClientDelegate,CLLocationManagerDelegate>
@property (nonatomic, strong) DBRestClient *restClient;
@property (strong, nonatomic) UIImage * cameraImage;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) float latitude;
@property (assign, nonatomic) float longitude;
@property (strong, nonatomic) ListViewController * listView;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) CLPlacemark *placemark;
@property (strong, nonatomic) NSString * cityName;
@property (strong, nonatomic) MapViewController * mapView;
@property (nonatomic,strong) UIView * backgroundView;
@property (nonatomic,strong) UIActivityIndicatorView * spinner;

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
- (IBAction)takePhotoButtonPressed:(id)sender;
- (IBAction)uploadPhotoButtonPressed:(id)sender;
- (IBAction)showListViewPressed:(id)sender;
- (IBAction)showMapPressed:(id)sender;
@end
