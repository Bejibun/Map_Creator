//
//  CreateNotesVC.m
//  Info_Gain_Project
//
//  Created by new owner on 12/5/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import "CreateNotesVC.h"

@interface CreateNotesVC ()
{
    NSMutableArray *pickerArray;
    NSInteger currentPicked;
    BOOL validated;
}

@end

@implementation CreateNotesVC
@synthesize timePicker,commentField,hourField, minuteField, locationField, loadingVC, longlat;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self initUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    
    [self populatePickerView];
    
    locationField.layer.borderColor = [UIColor blackColor].CGColor;
    locationField.layer.borderWidth = 1;
    
}

- (void)populatePickerView
{
    pickerArray = [NSMutableArray arrayWithObjects:@"AM",@"PM", nil];
    currentPicked = 0;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    //Dismiss Keyboard
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //check if the HOUR and MINUTE are valid
    [self validateTime:textField];
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == locationField && ![locationField.text isEqualToString:@""]) {
        [self validateAddress:textView.text];
    }
    
    [textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}

-(BOOL)validateTime:(UITextField *)textField
{
    BOOL checker = YES;
    
    if (textField == hourField || textField == minuteField) {
        
        
        if (textField == hourField && ![hourField.text isEqualToString:@""]) {
            checker = NO;
            checker = [self checkPattern:hourField.text];
            
            if (checker) {
                [self checkForMidnightTime];
                if (!(hourField.text.integerValue >= 0 && hourField.text.integerValue <= 12)) {
                    checker = NO;
                    
                }
            }
        }
        
        if (textField == minuteField && ![minuteField.text isEqualToString:@""]) {
            checker = NO;
            checker = [self checkPattern:minuteField.text];
            
            if (checker) {
                if (!(minuteField.text.integerValue >= 0 && minuteField.text.integerValue <= 59)) {
                    checker = NO;
                    
                    
                }
            }
        }
        
        if (!checker) {
            UIAlertView *message = [[UIAlertView alloc]initWithTitle:@"Wrong Time Format" message:@"Fix the Format" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [message show];
            
            [textField becomeFirstResponder];
        }
    }
    return checker;
}

-(void)checkForMidnightTime
{
    if ([hourField.text isEqualToString:@"12"] && currentPicked == 0) {
        
        UIAlertView *midnightAlert = [[UIAlertView alloc]initWithTitle:@"Change HH from 12 -> 00" message:@"Convert value" delegate:self cancelButtonTitle:@"Convert" otherButtonTitles: nil];
        [midnightAlert show];
        hourField.text = @"00";
    }
    else if ([hourField.text isEqualToString:@"00"] && currentPicked == 1) {
        
        UIAlertView *midnightAlert = [[UIAlertView alloc]initWithTitle:@"Change HH from 00 -> 12" message:@"Convert value" delegate:self cancelButtonTitle:@"Convert" otherButtonTitles: nil];
        [midnightAlert show];
        hourField.text = @"12";
    }
}

-(BOOL)checkPattern:(NSString *)input
{
    NSString *contactRegex = @"[0-9]{2}";
    NSPredicate *checkContact = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", contactRegex];
    return [checkContact evaluateWithObject:input];
}

- (void)overlayLoadingAddress
{
    loadingVC = [[LoadingViewController alloc]
                                        initWithNibName:@"LoadingViewController" bundle:nil];
    [self.view addSubview:loadingVC.view];
    [loadingVC setupUI:@"Validatin Address"];

}

- (void)doneLoading
{
    [loadingVC.view removeFromSuperview];
}

-(void)validateAddress:(NSString *)inputAddress
{
    [self overlayLoadingAddress];
    longlat = nil;
    //Validating Address
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:inputAddress
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (!error) {
                         for (CLPlacemark* aPlacemark in placemarks)
                         {
                             // Process the placemark.
                             NSLog(@"%@",aPlacemark);
                             CLLocation *location = aPlacemark.location;
                             CLLocationCoordinate2D coordinate = location.coordinate;
                             NSLog(@"%f", coordinate.longitude);
                             NSLog(@"%f", coordinate.latitude);
                             
                             longlat = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
                             
                         }
                     }
                     else
                     {
                         UIAlertView *message = [[UIAlertView alloc]initWithTitle:@"Error Validate Address" message:@"Put a valid address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                         [message show];
                     }
                     [self doneLoading];
                     
                 }];
}

#pragma PickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //Show Content to Picker View
    NSString *title = @"";
    
    
    //Get the content for Picker View
    title = [pickerArray objectAtIndex:row];
    
    return title;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    currentPicked = row;
    
    [self checkForMidnightTime];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)createTapped:(id)sender {
    
    NSLog(@"Note list is created");

    if (longlat != nil && [self validateTime:hourField] && [self validateTime:minuteField] && ![commentField.text isEqualToString:@""]) {
        Notes *nL = [[Notes alloc]init];
        
        //save the data
        nL.notesComment = commentField.text;
        nL.notesTime = [NSString stringWithFormat:@"%@ : %@ %@", hourField.text, minuteField.text, [pickerArray objectAtIndex:currentPicked]];
        
        CLLocationCoordinate2D coord = longlat.coordinate;
        nL.notesLongitude = [NSString stringWithFormat:@"%f", coord.longitude];
        nL.notesLatitude = [NSString stringWithFormat:@"%f", coord.latitude];

        [DataHandler saveDataToDisk:nL];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else{
        UIAlertView *fixIssue = [[UIAlertView alloc]initWithTitle:@"Fix" message:@"Fix the Issue" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [fixIssue show];
    }
    
//    ProductList *pL = [[ProductList alloc]init];
//    pL.productID = productName.text;
//    pL.productDescription = desctiptionText.text;
//    pL.productImage = [pickerArray objectAtIndex:currentPicked];
//    
//    [DataHandler saveDataToDisk:pL];
    
    
}
@end
