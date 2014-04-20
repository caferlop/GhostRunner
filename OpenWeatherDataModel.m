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
    NSDictionary * weatherResponse;
}


-(id)init
{
    self=[super init];
    
    weatherResponse = @{};
    
    return self;
}

-(void)getCurrent:(CLLocation*)Location
{
    NSString *const urlstring = @"http://api.openweathermap.org/data/2.5/weather";
    
    NSString *weatherURLText = [NSString stringWithFormat:@"%@?lat=%i&lon=%i",urlstring,(int)Location.coordinate.latitude,(int)Location.coordinate.longitude];
    NSLog(@"%@",weatherURLText);
    NSURL *weatherURL = [NSURL URLWithString:weatherURLText];
    NSURLRequest *weatherRequest = [NSURLRequest requestWithURL:weatherURL];
    
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:weatherRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation
                                               , id responseObject) {
        weatherResponse =(NSDictionary*)responseObject;
        [self parseWeatherService];
        NSLog(@"JSON: %@", responseObject);
        
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle error
        weatherResponse=@{};
        UIAlertView * ErrorAlerView = [[UIAlertView alloc]initWithTitle:@"Error Getting Data" message:@"Error getting data from weather Api" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [ErrorAlerView show];
    }];
    
    [operation start];
}
-(void)parseWeatherService
{
    
    self.cloudCover = [weatherResponse[@"clouds"][@"all"]integerValue];
    self.tempCurrent = [self kelvinToCelsius:[weatherResponse[@"main"][@"temp"]doubleValue]];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"JSONReceived" object:self userInfo:@{@"temperature":[NSString stringWithFormat:@"%iºC",(int)self.tempCurrent]}];
    NSLog(@"Porcentaje Nubosidad:%d",self.cloudCover);
    NSLog(@"Temperatura:%f",self.tempCurrent);
    
}
-(double)kelvinToCelsius:(double)degreesKelvin
{
    const double ZERO_CELSIUS_IN_KELVIN =273.15;
    return degreesKelvin - ZERO_CELSIUS_IN_KELVIN;
}

@end
