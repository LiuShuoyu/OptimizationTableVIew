//
//  DataCellModel.m
//  OptimizationTableVIew
//
//  Created by 刘小弟 on 16/9/6.
//  Copyright © 2016年 na. All rights reserved.
//

#import "DataCellModel.h"

@implementation DataCellModel

-(id)initWithDic:(NSDictionary *)dic
{
    self =[super init];
    if (self)
    {
        self.title =dic[@"title"];
        self.imageURLString =dic[@"imgsrc"];
    }
    return self;
}

-(void)goCachCellFrame;  //缓存cel的fram
{
    self.cellHeight =150;
    self.appIconIamgeSize=CGSizeMake(80, 60);
}
@end
