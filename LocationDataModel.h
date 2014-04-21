//
//  LocationDataModel.h
//  GhostRunner
//
//  Created by Carlos Fernández López on 18/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//
/* The LocationDataModel is in charge to locate our position plus once the position is gotten, do a request to the OpenWeather Api to retreive a JSON object through the OpenWeatherDataModel class*/
#import <Foundation/Foundation.h>

@interface LocationDataModel : NSObject<CLLocationManagerDelegate>

@property (nonatomic,strong) NSMutableArray * arrayOfCoordinates;
@property (nonatomic,strong) CLLocation * Coordinates;
@property (nonatomic,strong) NSString*Locality;
@property (nonatomic) CGFloat temperature;


@end
 
