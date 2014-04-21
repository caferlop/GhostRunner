//
//  OpenWeatherDataModel.h
//  GhostRunner
//
//  Created by Carlos Fernández López on 18/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//
/*The openweatherDatamodel will help us to implement the request to the OpenWeather api, and get the forecast from the request. THe request will be an URL based on coordinates. At the end, the temperature from the JSON object requested, will be reflected in the weather widget view reflected in TrackViewController class. To perform the JSON request, previously added AFNETWORKING 2.2 library through cocoapods*/

#import <Foundation/Foundation.h>

@interface OpenWeatherDataModel : NSObject

@property (nonatomic) CGFloat tempCurrent;
@property (nonatomic) NSInteger  cloudCover;

-(void)getCurrent:(CLLocation*)Location;

@end
 
