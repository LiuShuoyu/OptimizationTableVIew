//
//  DataCellModel.h
//  OptimizationTableVIew
//
//  Created by 刘小弟 on 16/9/6.
//  Copyright © 2016年 na. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataCellModel : NSObject

@property (nonatomic, strong) NSString *title;
 @property (nonatomic, strong) UIImage *cellIamge; //缓存的Iamge
@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) NSString *appDownString;
@property (assign,nonatomic)  float cellHeight;
@property(assign,nonatomic) CGSize appIconIamgeSize;

-(void)goCachCellFrame;  //缓存cel的fram
-(id)initWithDic:(NSDictionary *)dic;

@end
