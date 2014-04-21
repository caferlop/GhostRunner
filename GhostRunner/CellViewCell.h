//
//  CellViewCell.h
//  GhostRunner
//
//  Created by Carlos Fernández López on 21/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Nombre;
@property (weak, nonatomic) IBOutlet UILabel *Locality;
@property (weak, nonatomic) IBOutlet UILabel *Date;

@end
