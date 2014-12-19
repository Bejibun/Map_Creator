//
//  ShowMapVC.h
//  Info_Gain_Project
//
//  Created by new owner on 12/5/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapViewAnnotation.h"

@interface ShowMapVC : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) NSArray *noteListArray;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
