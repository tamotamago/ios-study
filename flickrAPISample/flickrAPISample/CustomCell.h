//
//  CustomCell.h
//  flickrAPISample
//
//  Created by 田村 航弥 on 2012/11/13.
//  Copyright (c) 2012年 武田 祐一. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageURLString;

@property (nonatomic, weak) IBOutlet UIImageView    *cellImageView;
@property (nonatomic, weak) IBOutlet UILabel        *titleLabel;

@end
