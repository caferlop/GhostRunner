//
//  LocationDataModel.m
//  GhostRunner
//
//  Created by Carlos Fernández López on 18/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import "LocationDataModel.h"

@implementation LocationDataModel
{
    CLLocationManager * locationManager;
    BOOL updatingLocation;
    NSError * lastLocationError;
    CLGeocoder * geocoder;
    CLPlacemark * placeMark;
    BOOL performingReverseGeocoding;
}
//----------------------------------------------------------------------
#pragma mark Init LocationDataModel
//----------------------------------------------------------------------
-(id)init
{
    if((self=[super init]))
    {
        locationManager = [[CLLocationManager alloc]init];
        geocoder = [[CLGeocoder alloc]init];
        [self startLocationManager];
    }
    return self;
}
//----------------------------------------------------------------------
#pragma mark Init startLocationManager
// if the location services are enabled, set the location manager. Added a perform selector to stop location manager after 60 seconds.
//----------------------------------------------------------------------
-(void)startLocationManager
{
    if([CLLocationManager locationServicesEnabled])
    {
        locationManager.delegate=self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        [self startUpdatingLocation];
        [self performSelector:@selector(didTimeOut:) withObject:nil afterDelay:60];
        
    }
}
//----------------------------------------------------------------------
#pragma mark Init startUpdatingLocation
// if the location services are enabled, startUpdating location, and asing yes to the bool variable.
//----------------------------------------------------------------------

-(void)startUpdatingLocation
{
    if([CLLocationManager locationServicesEnabled])
    {
        [locationManager startUpdatingLocation];
        updatingLocation=YES;
    }
}
//----------------------------------------------------------------------
#pragma mark Init stopUpdatingLocation
// if the location services are enabled, startUpdating location, and assing yes to the bool variable.
//----------------------------------------------------------------------
-(void)stopUpdatingLocation
{
    if(updatingLocation)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didTimeOut:) object:nil];
        [locationManager stopUpdatingLocation];
        locationManager.delegate = nil;
        updatingLocation = NO;
    }
}
-(void)didTimeOut:(id)obj
{
    NSLog(@"***** Time out");
    
    if(self.Coordinates == nil)
    {
        lastLocationError = [NSError errorWithDomain:@"LocationError" code:1 userInfo:nil];
    }
    
}
//------------------------------------------------------------------------------------//
#pragma  Getting String from Placemark
//------------------------------------------------------------------------------------//
-(NSString*)stringFromPlaceMark:(CLPlacemark*)thePlacemark
{
    return [NSString stringWithFormat:@"%@", thePlacemark.locality];
}
//------------------------------------------------------------------------------------//
#pragma  mark CLLocationManagerDelegate
//------------------------------------------------------------------------------------//
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError %@",error);
    if(error.code == kCLErrorLocationUnknown)
    {
        return;
    }
    [self stopUpdatingLocation];
    lastLocationError = error;
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation * newLocation = locations.lastObject;
    if([newLocation.timestamp timeIntervalSinceNow]<-5.0)
    {
        return;
    }
    if(newLocation.horizontalAccuracy <0)
    {
        return;
    }
    [self.arrayOfCoordinates addObject:newLocation];
    // NSLog(@"count:%i",[self.arrayOfCoordinates count]);
    
    // NSLog(@"didUpdateLocation %@",newLocation);
    
    
}

@end
