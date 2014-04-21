//
//  TrackViewController.h
//  GhostRunner
//
//  Created by Carlos Fernández López on 18/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherView.h"
#import <MapKit/MapKit.h>

@interface TrackViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *Temperature;
@property (weak, nonatomic) IBOutlet UITextField *Location;
@property (strong, nonatomic) IBOutlet WeatherView *weatherWidget;
@property (strong, nonatomic) IBOutlet MKMapView *MapView;


- (IBAction)Play:(id)sender;
- (IBAction)Pause:(id)sender;
- (IBAction)Stop:(id)sender;
- (IBAction)Options:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *CenterLocation;

@end
