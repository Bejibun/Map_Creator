//
//  Notes.m
//  Info_Gain_Project
//
//  Created by new owner on 12/5/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import "Notes.h"

@implementation Notes
@synthesize notesComment, notesTime, notesLongitude, notesLatitude;

+ (NSDictionary*) createDictionaryFromNoteList:(Notes *)noteList
{
    //Create Dictionary for the product List
    NSLog(@"Create Dictionary from Produt List");
    NSString* comment = [NSString stringWithString:noteList.notesComment];
    NSString* longs = [NSString stringWithString:noteList.notesLongitude];
    NSString* lats = [NSString stringWithString:noteList.notesLatitude];
    NSString* time = [NSString stringWithString:noteList.notesTime];
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    
    [dict setObject:comment forKey:@"comment"];
    [dict setObject:longs forKey:@"longitude"];
    [dict setObject:lats forKey:@"latitude"];
    [dict setObject:time forKey:@"time"];
    
    return dict;
}

@end
