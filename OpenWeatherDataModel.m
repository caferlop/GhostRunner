//
//  OpenWeatherDataModel.m
//  GhostRunner
//
//  Created by Carlos Fernández López on 18/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import "OpenWeatherDataModel.h"
#import "AFNetworking.h"

@implementation OpenWeatherDataModel
{
    //Dictionary were the JSON object will be "catched"
    NSDictionary * weatherResponse;
}


-(id)init
{
    self=[super init];
    
    weatherResponse = @{};
    
    return self;
}
//-------------------------------------------------------------------------------------------
#pragma mark JSON Request method
//Method were the JSON request is performed. This method is implemented in the LocationDataModel once reverse geocoding has been perform succesfully.
//-------------------------------------------------------------------------------------------
-(void)getCurrent:(CLLocation*)Location
{
    NSString *const urlstring = @"http://api.openweathermap.org/data/2.5/weather";
    
    NSString *weatherURLText = [NSString stringWithFormat:@"%@?lat=%i&lon=%i",urlstring,(int)Location.coordinate.latitude,(int)Location.coordinate.longitude];
    
    NSURL *weatherURL = [NSURL URLWithString:weatherURLText];
    
    NSURLRequest *weatherRequest = [NSURLRequest requestWithURL:weatherURL];
    
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:weatherRequest];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        weatherResponse =(NSDictionary*)responseObject;
        
        [self parseWeatherService];
       
        
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle error
        weatherResponse=@{};
        
        UIAlertView * ErrorAlerView = [[UIAlertView alloc]initWithTitle:@"Error Getting Data" message:@"Error getting data from weather Api" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [ErrorAlerView show];
    }];
    
    [operation start];
}
//-------------------------------------------------------------------------------------------
#pragma mark Parse JSON method
//Method were the JSON is parsed. This method is implemented in the request method if the operation block is succesfull
//-------------------------------------------------------------------------------------------

-(void)parseWeatherService
{
    
    self.cloudCover = [weatherResponse[@"clouds"][@"all"]integerValue];
    
    self.tempCurrent = [self kelvinToCelsius:[weatherResponse[@"main"][@"temp"]doubleValue]];
    
    //Perform NSNotificationcenter to notify when the temperature is available to the widget.
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"JSONReceived" object:self userInfo:@{@"temperature":[NSString stringWithFormat:@"%iºC",(int)self.tempCurrent]}];
    
   
    
    
}
//-------------------------------------------------------------------------------------------
#pragma mark Kelvin to celsius method
//The temperature scalation retreived from the JSON object, is in kelvin, but will be displayed in celsius in the widget, therefore a conversion method is needed.
//-------------------------------------------------------------------------------------------
-(double)kelvinToCelsius:(double)degreesKelvin
{
    const double ZERO_CELSIUS_IN_KELVIN =273.15;
    return degreesKelvin - ZERO_CELSIUS_IN_KELVIN;
}

@end
