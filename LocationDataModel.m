//
//  LocationDataModel.m
//  GhostRunner
//
//  Created by Carlos Fernández López on 18/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import "LocationDataModel.h"
#import "OpenWeatherDataModel.h"

@implementation LocationDataModel
{
    CLLocationManager * locationManager;
    CLLocation *location;
    BOOL updatingLocation;
    NSError * lastLocationError;
    CLGeocoder * geocoder;
    NSError * lastGeocodingError;
    CLPlacemark * placemark;
    BOOL performingReverseGeocoding;
    OpenWeatherDataModel * Weather;
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
        [self startUpdatingLocation];
        self.arrayOfCoordinates = [[NSMutableArray alloc]init];
        //[[NSNotificationCenter defaultCenter]postNotificationName:@"JSONReceived" object:self userInfo:@{@"locality":self.locality,@"temperature":[NSString stringWithFormat:@"%f",self.temperature]}];
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
        
        [self performSelector:@selector(didTimeOut:) withObject:nil afterDelay:60];
        [self performSelector:@selector(performingReverseGeocodingAgain) withObject:nil afterDelay:3600];
        
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
// stop updating location
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
#pragma  performingReverseGeocoding
//------------------------------------------------------------------------------------//
-(void)performingReverseGeocodingAgain
{
    performingReverseGeocoding=YES;
    NSLog(@"perform");
}
//------------------------------------------------------------------------------------//
#pragma  Getting String from Placemark
// With this two methods and the reverse geocoding process, get from the coordinates the name of the locality and country.
//------------------------------------------------------------------------------------//
-(NSString*)stringFromPlaceMark:(CLPlacemark*)thePlacemark
{
    return [NSString stringWithFormat:@"%@,%@", thePlacemark.locality,thePlacemark.country];
}
-(NSString*)locality
{
    return [self stringFromPlaceMark:placemark];
}
//------------------------------------------------------------------------------------//
#pragma  mark CLLocationManagerDelegate
// Delegate methos of CLLocation that will take care to keep updated the location
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
    //getting the last location once the accurazy is good enought.
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
    
    
    //Performin reversegeocoding, to get the locality from the coordinates. The locality will be passed as a string to the openweatherdatamodel to perform the request to the web service.
    CLLocationDistance distance = MAXFLOAT;
    if (location != nil) {
        distance = [newLocation distanceFromLocation:location];
    }
    
    if (location == nil || location.horizontalAccuracy > newLocation.horizontalAccuracy) {
        
        lastLocationError = nil;
        location = newLocation;
      
        
        if (newLocation.horizontalAccuracy <= locationManager.desiredAccuracy) {
            //NSLog(@"*** We're done!");
            
            
            if (distance > 0) {
                performingReverseGeocoding = NO;
            }
        }
        
        if (!performingReverseGeocoding) {
            NSLog(@"*** Going to geocode");
            
            performingReverseGeocoding = YES;
            [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
                
                
                lastGeocodingError = error;
                if (error == nil && [placemarks count] > 0)
                {
                    placemark = [placemarks lastObject];
                    
                    //Once we´ve got the placemark, instantiate OpenWeatherDataModel class and perform a JSON request, passing a location value, that gots our coordinates.
                    
                    Weather = [[OpenWeatherDataModel alloc]init];
                    [Weather getCurrent:location];
                    
                    self.locality = [self locality];
                    self.temperature = Weather.tempCurrent;
                    //With the NSNotificationcenter, will notify to the view Controller when to perform the method that will give value to the textfield properties of the Trackviewcontroller
                   [[NSNotificationCenter defaultCenter]postNotificationName:@"ReverseGeocodingperformed" object:self userInfo:@{@"locality":self.locality}];
                                                                                                                     
                } else {
                    placemark = nil;
                }
                
               // performingReverseGeocoding = NO;
                
            }];
        }
        
    } else if (distance < 1.0)
    {
        NSTimeInterval timeInterval = [newLocation.timestamp timeIntervalSinceDate:location.timestamp];
        if (timeInterval > 10) {
            NSLog(@"*** Force done!");
                    }
    }

   
   

}

@end
 
