//
//  TrackViewController.m
//  GhostRunner
//
//  Created by Carlos Fernández López on 18/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import "TrackViewController.h"
#import "LocationDataModel.h"
#import "DetailViewController.h"

@interface TrackViewController ()

@end

@implementation TrackViewController
{
    LocationDataModel * Location;
    MKPolyline * line;
    NSTimer * PlotTimer;
    BOOL PauseTimer;
    
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
    PauseTimer=NO;
    NSLog(@"log");
    
    [self centerMapOnUserLocation];
    
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
    PauseTimer=NO;
    if(PauseTimer==NO)
    {
    PlotTimer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(plot) userInfo:nil repeats:YES];
    }
}

- (IBAction)Pause:(id)sender {
    
    PauseTimer=YES;
    
}

- (IBAction)Stop:(id)sender {
    
    [PlotTimer invalidate];
    PlotTimer=nil;
    UIAlertView * SaveAlertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Do you want to" delegate:self cancelButtonTitle:@"cancel Track?" otherButtonTitles:@"save Track?",nil];
    [SaveAlertView show];
    
   
}
//------------------------------------------------------------------------------------------//
#pragma mark Delegate method of UIAlerview
//Implemented in stop button
//------------------------------------------------------------------------------------------//
- (void)alertView:(UIAlertView  *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        // Yes, do something
    }
    else if (buttonIndex == 1)
    {
       
        [self performSegueWithIdentifier:@"DetailSegue" sender:self];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        //[self presentingViewController];
    }
}
- (IBAction)Options:(id)sender {
    
    [self performSegueWithIdentifier:@"SavedTracksSegue" sender:self];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
//------------------------------------------------------------------------------------------//
#pragma mark Prepare for segue method delegate

//------------------------------------------------------------------------------------------//
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"DetailSegue"])
    {
        UINavigationController * navigationController = segue.destinationViewController;
        DetailViewController * DetailController = (DetailViewController*)navigationController.topViewController;
        DetailController.locationtext=self.Location.text;
        
        
    }
    if([segue.identifier isEqualToString:@"SavedTracksSegue"])
    {
        //DetailViewController * DetailController = segue.destinationViewController;
        
    }
}
//------------------------------------------------------------------------------------------//
#pragma mark Location and Tracking Method
//------------------------------------------------------------------------------------------//
-(void)centerMapOnUserLocation
{
    Location = [[LocationDataModel alloc]init];
    self.MapView.delegate = self;
    self.MapView.showsUserLocation=YES;
    MKUserLocation * userLocation = self.MapView.userLocation;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 100, 100);
    
    [self.MapView setRegion:region animated:YES];
    
}
//------------------------------------------------------------------------------------------//
#pragma mark Drawing polyline
//------------------------------------------------------------------------------------------//
-(void)plotRouteOnMap
{
    
    CLLocationCoordinate2D * coordinateArray = malloc(sizeof(CLLocationCoordinate2D)*[Location.arrayOfCoordinates count]);
    
    int caIndex = 0;
    for (CLLocation * loc in Location.arrayOfCoordinates)
    {
        coordinateArray[caIndex] = loc.coordinate;
        caIndex++;
    }
    line = [MKPolyline polylineWithCoordinates:coordinateArray count:[Location.arrayOfCoordinates count]];
    
    free(coordinateArray);
    
    [self.MapView addOverlay:line];
    
    // NSLog(@"count: %i",[UserLocation.arrayOfCoordinates count]);
    NSLog(@"countC:%i",caIndex);
    
}
-(void)plot
{
    if(PauseTimer==NO)
    {
    [self plotRouteOnMap];
    }
    //What happens if the ploting is paused, the user moves, and restart the ploting again? ...TODO.
}
//------------------------------------------------------------------------------------------//
#pragma mark MKMapViewDelegate
//------------------------------------------------------------------------------------------//
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.MapView.centerCoordinate = userLocation.location.coordinate;
    
    // [self ploRouteOnMap];
    
}
//------------------------------------------------
#pragma mark MKOverlayDelegate
//------------------------------------------------
-(MKOverlayRenderer*)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer * polyline = [[MKPolylineRenderer alloc]initWithPolyline:overlay];
    polyline.strokeColor = [UIColor blueColor];
    polyline.lineWidth = 2.0;
    
    return polyline;
}
@end

