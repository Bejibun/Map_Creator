//
//  Notes.h
//  Info_Gain_Project
//
//  Created by new owner on 12/5/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Notes : NSObject

@property (strong, nonatomic) NSString *notesComment;
@property (strong, nonatomic) NSString *notesTime;
@property (strong, nonatomic) NSString *notesLongitude;
@property (strong, nonatomic) NSString *notesLatitude;

+ (NSDictionary*) createDictionaryFromNoteList:(Notes*)noteList;

@end
