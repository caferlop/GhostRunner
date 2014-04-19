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
        // Custom initialization
        //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fillLabels:) name:@"JSONReceived" object:nil];
    }
    return self;
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fillTemperatureLabel:) name:@"JSONReceived" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fillLocationLabel:) name:@"ReverseGeocodingperformed" object:nil];
    //Location = [[LocationDataModel alloc]init];
    //self.Temperature.text = [NSString stringWithFormat:@"%f Cº",Location.temperature];
    //self.Location.text = Location.locality;
    
	// Do any additional setup after loading the view.
}
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

@end
