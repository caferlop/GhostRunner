//
//  TrackViewController.h
//  GhostRunner
//
//  Created by Carlos Fernández López on 18/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//
/*The trackviewController will implement the MapView and the widget view. To implement the mapview, it is necessary to become delegate of MKMapview. To fill the labels in the weather widget, trackviewcontroller is as well observer of the NSNotificationCenter. Furthermore, it´s got a play,pause,stop,options menu to start the track trace ploting, pause it, stop it and save it, and get access to the track saved list through the options button.*/

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
