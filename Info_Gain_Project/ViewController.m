//
//  ViewController.m
//  Info_Gain_Project
//
//  Created by new owner on 12/5/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import "ViewController.h"
#import "CreateNotesVC.h"
#import "showMapVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createNotesTapped:(id)sender
{
    //Jump to Create Notes VC
    NSLog(@"Create Notes VC is called");
    
    CreateNotesVC *createNotesVC = [[CreateNotesVC alloc]initWithNibName:@"CreateNotesVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:createNotesVC animated:YES];
}

- (IBAction)showMapTapped:(id)sender
{
    //Jump to Show Map VC
    NSLog(@"Show Map VC is called");
    
    ShowMapVC *showMapVC = [[ShowMapVC alloc]initWithNibName:@"ShowMapVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:showMapVC animated:YES];
}
@end
