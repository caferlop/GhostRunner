//
//  TrackViewController.m
//  GhostRunner
//
//  Created by Carlos Fernández López on 18/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import "TrackViewController.h"
#import "LocationDataModel.h"


@interface TrackViewController ()

@end

@implementation TrackViewController
{
    LocationDataModel * Location;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"log");
        // Custom initialization
        //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fillLabels:) name:@"JSONReceived" object:nil];
    }
    return self;
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    NSLog(@"log");
    
    Location = [[LocationDataModel alloc]init];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fillTemperatureLabel:) name:@"JSONReceived" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fillLocationLabel:) name:@"ReverseGeocodingperformed" object:nil];
  
}
//------------------------------------------------
#pragma mark NSNotification Methods.
//------------------------------------------------
-(void)fillTemperatureLabel:(NSNotification*)notification
{
    self.Temperature.text=notification.userInfo[@"temperature"];
   
    NSLog(@"Notification temperature received");
}
-(void)fillLocationLabel:(NSNotification*)notification
{
    
    self.Location.text=notification.userInfo[@"locality"];
    
    NSLog(@"Notification  location received");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//------------------------------------------------
#pragma mark Action Buttons.
//------------------------------------------------
- (IBAction)Play:(id)sender {
}

- (IBAction)Pause:(id)sender {
}

- (IBAction)Stop:(id)sender {
}

- (IBAction)Options:(id)sender {
}
@end

