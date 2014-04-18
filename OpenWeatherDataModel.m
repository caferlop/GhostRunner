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

-(void)getCurrent:(NSString *)Jquery
{
    NSString *const urlstring = @"http://api.openweathermap.org/data/2.5/weather ";
    
    NSString *weatherURLText = [NSString stringWithFormat:@"%@?q=%@",
                                urlstring, Jquery];
    NSURL *weatherURL = [NSURL URLWithString:weatherURLText];
    NSURLRequest *weatherRequest = [NSURLRequest requestWithURL:weatherURL];
    
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:weatherRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation
                                               , id responseObject) {
        weatherResponse =(NSDictionary*)responseObject;
        [self parseWeatherService];
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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
    
}

@end
