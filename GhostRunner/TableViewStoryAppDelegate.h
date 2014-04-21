//
//  TableViewStoryAppDelegate.h
//  GhostRunner
//
//  Created by Carlos Fernández López on 18/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewStoryAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


-(void)saveContext;
-(NSURL*)applicationDocumentsDirectory;


@end
