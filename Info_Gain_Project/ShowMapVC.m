//
//  ShowMapVC.m
//  Info_Gain_Project
//
//  Created by new owner on 12/5/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import "ShowMapVC.h"

@interface ShowMapVC ()

@end

@implementation ShowMapVC
@synthesize noteListArray,mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [mapView addAnnotations:[self createAnnotations]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchJSONInformation
{
    //Fetch Data from current JSON in Document path
    NSLog(@"Fetch JSON file from Document path");
    NSString *documentsDirectory = [NSHomeDirectory()
                                    stringByAppendingPathComponent:@"Documents"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    noteListArray = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    
}

-(NSDictionary *)getContent:(NSString *)fileName
{
    NSError* error = nil;
    
    NSString *documentsDirectory = [NSHomeDirectory()
                                    stringByAppendingPathComponent:@"Documents"];
    
    NSString *filePath = [documentsDirectory
                          stringByAppendingPathComponent:fileName];
    
    NSString* json = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if ([self isStringEmpty:json])
    {
        if (error != nil)
        {
            NSLog(@"** Error getting file: %@", [error localizedDescription]);
        }
    }
    else
    {
        return [self parseJSONFromString:json];
    }
    
    return nil;
}

- (NSDictionary*)parseJSONFromString:(NSString*)jsonString
{
    
    //Parse Specific JSON into Dictionary
    NSLog(@"Parse Specific JSON into dictionary");
    NSError* error = nil;
    
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (jsonDict == nil)
    {
        NSLog(@"WARNING: Something went wrong; could not Deserialize JSON!");
        
        if (error != nil)
            NSLog(@"ERROR: %@", [error localizedDescription]);
    }
    
    return jsonDict;
}

- (BOOL) isStringEmpty:(NSString *)string
{
    if([string length] == 0)
    {
        //string is empty or nil
        return YES;
    }
    
    if(![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
    {
        //string is all whitespace
        return YES;
    }
    
    return NO;
}

-(NSMutableArray *)createAnnotations
{
    
    //Create Annotation
    NSLog(@"Create annotations");
    
    NSMutableArray *addedAnnotations = [[NSMutableArray alloc]init];
    
    mapView.showsUserLocation = YES;
    
    [self fetchJSONInformation];
    
    for (int i = 0; i < [noteListArray count]; i++) {
        NSDictionary *infoDict = [[NSDictionary alloc]init];
        infoDict = [self getContent:[noteListArray objectAtIndex:i]];
        
        NSNumber *latitude = [infoDict objectForKey:@"latitude"];
        NSNumber *longitude = [infoDict objectForKey:@"longitude"];
        NSString *titled = [infoDict objectForKey:@"time"];
        NSString *subtitled = [infoDict objectForKey:@"comment"];
        

        
        CLLocationCoordinate2D coord;
        coord.latitude = latitude.doubleValue;
        coord.longitude = longitude.doubleValue;
        
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = coord;
        annotationPoint.title = titled;
        annotationPoint.subtitle = subtitled;
        
        //        MapViewAnnotation *annotation = [[MapViewAnnotation alloc] initWithTitle:title AndCoordinate:coord];
        
        [addedAnnotations addObject:annotationPoint];

    }
    return addedAnnotations;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
