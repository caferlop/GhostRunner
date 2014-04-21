//
//  SavedTracksViewController.h
//  GhostRunner
//
//  Created by Carlos Fernández López on 21/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedTracksViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray * matchingobjects;
@property (nonatomic,strong) UITableView * tableView;

@end
