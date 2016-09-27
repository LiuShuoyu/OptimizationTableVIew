//
//  CustomTableViewCell.m
//  OptimizationTableVIew
//
//  Created by 刘小弟 on 16/9/6.
//  Copyright © 2016年 na. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updataImageCell:(DataCellModel *)dataCell
{
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataCell.imageURLString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
        UIGraphicsBeginImageContextWithOptions(dataCell.appIconIamgeSize, YES, 0.0);
        CGRect rect = CGRectMake(0, 0, dataCell.appIconIamgeSize.width, dataCell.appIconIamgeSize.height);
        [image drawInRect:rect];
        dataCell.cellIamge =UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndPDFContext();
    }];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataCell.imageURLString] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}

-(void)starDownImageCell:(DataCellModel *)dataCell
{
    self.imageView.image = dataCell.cellIamge;
}

@end
