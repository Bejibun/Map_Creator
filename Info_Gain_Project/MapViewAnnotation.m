//
//  MapViewAnnotation.m
//  Info_Gain_Project
//
//  Created by new owner on 12/6/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import "MapViewAnnotation.h"

@implementation MapViewAnnotation

@synthesize coordinate=_coordinate;
@synthesize title=_title;

-(id) initWithTitle:(NSString *) title AndCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    _title = title;
    _coordinate = coordinate;
    return self;
}


@end
