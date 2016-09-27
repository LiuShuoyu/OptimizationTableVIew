//
//  ViewController.m
//  OptimizationTableVIew
//
//  Created by 刘小弟 on 16/9/6.
//  Copyright © 2016年 na. All rights reserved.
//
#import "AFNetworking.h"
#import "ViewController.h"
#import "CustomTableViewCell.h"
#import "DataCellModel.h"
#define KScreenWidth  ([ UIScreen mainScreen].bounds.size.width)
static NSString *const url =
@"http://c.3g.163.com/nc/article/list/T1467284926140/0-40.html";


@interface ViewController ()

@property (nonatomic,strong) NSMutableArray *tableDataArray;
@property (nonatomic,strong) UILabel *headLodingLable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewViewDelegate 和 UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell =[tableView  dequeueReusableCellWithIdentifier:@"identifier"];
    DataCellModel *model =_tableDataArray[indexPath.row];
    if (cell==nil)
    {
        cell =[[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    cell.textLabel.text =model.title;
    cell.textLabel.numberOfLines =0;
    if (!model.cellIamge)
    {
        if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
        {
            [cell updataImageCell:model];
        }
        cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
    }
    else
    {
        cell.imageView.image = model.cellIamge;
    }
    return cell;
}

#pragma mark  - 高度缓存， 避免每次都计算。
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DataCellModel *model =_tableDataArray[indexPath.row];
    return model.cellHeight;

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

#pragma mark - 下载图片

- (void)loadImagesForOnscreenRows
{
    if (_tableDataArray.count > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            DataCellModel *model =_tableDataArray[indexPath.row];
            if (!model.cellIamge)
            {
                CustomTableViewCell *cell =(CustomTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                [cell updataImageCell:model];
            }
        }
    }
}

-(void)setTableViewDataSourceModelValue:(NSArray *)array
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _tableDataArray=[NSMutableArray new];
        
        for (NSDictionary *dic in array)
        {
            DataCellModel *model =[[ DataCellModel alloc]initWithDic:dic ];
            [model goCachCellFrame];  //缓存cell的cell的subVoiew的Frame
            [_tableDataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUI];
            [self.tableView reloadData];
            
        });
        
    });
}

-(void)setData
{
    AFHTTPSessionManager *manger =[AFHTTPSessionManager manager];
    manger.requestSerializer =[AFHTTPRequestSerializer serializer];
    manger.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSError *error =nil;
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:1 error:&error];
        [self setTableViewDataSourceModelValue:dic[@"T1467284926140"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error =%@",error);
    }];
}

-(void)setUI
{
    self.tableView.tableHeaderView =_tableDataArray?nil:self.headLodingLable;
}

#pragma mark - 赖加载

-(UILabel *)headLodingLable
{
    if (!_headLodingLable)
    {
        _headLodingLable =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
        _headLodingLable.text =@"loading.....";
        _headLodingLable.textAlignment=NSTextAlignmentCenter;

    }
    return _headLodingLable;
}




@end
