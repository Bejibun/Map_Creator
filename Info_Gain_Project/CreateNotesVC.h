//
//  CreateNotesVC.h
//  Info_Gain_Project
//
//  Created by new owner on 12/5/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHandler.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LoadingViewController.h"

@interface CreateNotesVC : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate,UITextViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *commentField;

@property (weak, nonatomic) IBOutlet UITextField *hourField;

@property (weak, nonatomic) IBOutlet UITextField *minuteField;

@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;

@property (weak, nonatomic) IBOutlet UITextView *locationField;

@property (strong, nonatomic) LoadingViewController *loadingVC;

@property (strong, nonatomic) CLLocation *longlat;

- (IBAction)createTapped:(id)sender;

@end
