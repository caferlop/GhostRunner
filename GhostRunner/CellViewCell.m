//
//  CellViewCell.m
//  GhostRunner
//
//  Created by Carlos Fernández López on 21/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import "CellViewCell.h"

@implementation CellViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
