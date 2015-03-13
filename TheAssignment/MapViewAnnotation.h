//
//  MapViewAnnotation.h
//  TheAssignment


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapViewAnnotation : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(id) initWithTitle:(NSString *) title AndCoordinate:(CLLocationCoordinate2D)coordinate;

@end
