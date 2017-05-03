
//
//  FirstViewController.m
//  通讯录Demo
//
//  Created by yeqiang on 2017/3/10.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "FirstViewController.h"
#import "AddressViewController.h"
#import "MessageViewController.h"
#import "InviteViewController.h"

@interface FirstViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    if (indexPath.row == 0) {
        AddressViewController *addVC = [[AddressViewController alloc] init];
        addVC.title = self.array[indexPath.row];
        [self.navigationController pushViewController:addVC animated:YES];
    } else if (indexPath.row == 1) {
        MessageViewController *addVC = [[MessageViewController alloc] init];
        addVC.title = self.array[indexPath.row];
        [self.navigationController pushViewController:addVC animated:YES];
    } else if (indexPath.row == 2) {
        InviteViewController *inviteVC = [[InviteViewController alloc] init];
        inviteVC.title = self.array[indexPath.row];
        [self.navigationController pushViewController:inviteVC animated:YES];
    }
    self.hidesBottomBarWhenPushed = NO;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [[NSMutableArray alloc] initWithObjects:@"我的好友", @"我的消息", @"邀请好友", nil];
    }
    return _array;
}

@end
