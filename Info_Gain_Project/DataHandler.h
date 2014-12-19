//
//  DataHandler.h
//  Info_Gain_Project
//
//  Created by new owner on 12/5/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notes.h"

@interface DataHandler : NSObject

+ (void) saveDataToDisk:(Notes*)noteList;

+ (BOOL) isDuplicateFileName:(NSString*)fileName;

@end
