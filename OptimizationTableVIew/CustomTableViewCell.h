//
//  CustomTableViewCell.h
//  OptimizationTableVIew
//
//  Created by 刘小弟 on 16/9/6.
//  Copyright © 2016年 na. All rights reserved.
//
#import "DataCellModel.h"
#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell


-(void)updataImageCell:(DataCellModel *)dataCell;
-(void)starDownImageCell:(DataCellModel *)dataCell;


@end
