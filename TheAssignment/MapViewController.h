//
//  MapViewController.h
//  TheAssignment

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>
#import <MapKit/MapKit.h>
#import "MapViewAnnotation.h"

@interface MapViewController : UIViewController<MKMapViewDelegate,DBRestClientDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) DBRestClient   * restClient;
@property (nonatomic, strong) NSMutableArray * nameArray;
@property (nonatomic, strong) NSMutableArray * imageNameArray;
@property (nonatomic, strong) NSMutableArray * annotationArray;
@property (nonatomic, strong) NSMutableArray * longitudeArray;
@property (nonatomic, strong) NSMutableArray * latitudeArray;
@property (assign, nonatomic) float latitude;
@property (assign, nonatomic) float longitude;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButtonPressed;
- (IBAction)backButtonPressed:(id)sender;
@end
