//
//  MapViewAnnotation.m
//  TheAssignment


#import "MapViewAnnotation.h"

@implementation MapViewAnnotation


-(id) initWithTitle:(NSString *) title AndCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    _title = title;
    _coordinate = coordinate;
    return self;
}
@end
