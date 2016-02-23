//
//  ViewController.m
//  15-自定义不等高的cell-xib(iOS8之前)
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 m14a.cn. All rights reserved.
//

#import "ViewController.h"
#import "XMGStatusCell.h"
#import "XMGStatus.h"
#import "MJExtension.h"

@interface ViewController ()
/** 所有的微博模型*/
@property (nonatomic ,strong) NSArray *statuses;
@end

@implementation ViewController


- (NSArray *)statuses
{
    if (!_statuses) {
        _statuses = [XMGStatus mj_objectArrayWithFilename:@"statuses.plist"];
    }
    return _statuses;
}

NSString *ID = @"status";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGStatusCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    // 大概行高
    self.tableView.estimatedRowHeight = 200;
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 传递模型数据
    cell.status = self.statuses[indexPath.row];
    return cell;
}

// 方案:在这个方法返回之前就要确定好cell的高度
XMGStatusCell *cell;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        // 如果没有找到，那么就去storyboard里面找
    }
    cell.status = self.statuses[indexPath.row];
    return cell.cellHeight;
}


@end

