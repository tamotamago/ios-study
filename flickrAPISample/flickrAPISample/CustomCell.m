//
//  CustomCell.m
//  flickrAPISample
//
//  Created by 田村 航弥 on 2012/11/13.
//  Copyright (c) 2012年 武田 祐一. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

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

-(void)layoutSubviews
{
    [self.cellImageView setImage:nil];
    self.titleLabel.text = _title;

    if (!_imageURLString) return;

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        UIImage *image;
        NSError *error = nil;
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageURLString] options:NSDataReadingUncached error:&error];
        if (!error) {
            image = [UIImage imageWithData:imageData];
            if (image && [image isKindOfClass:[UIImage class]]) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.cellImageView setImage:image];
                }];
            }
        }
    }];
}

@end
