//
//  NewFirendsViewCtrl.m
//  通讯录Demo
//
//  Created by yeqiang on 2017/4/28.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "NewFirendsViewCtrl.h"
#import "AddressTableView.h"

@interface NewFirendsViewCtrl () <AddressTableViewDelegate>

@property (nonatomic, strong) AddressTableView *tableView;

@end

@implementation NewFirendsViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter and getter
- (AddressTableView *)tableView {
    if (!_tableView) {
        _tableView = [[AddressTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.addressDelegate = self;
        _tableView.showIndex = YES;
        _tableView.canEdit = YES;
        _tableView.showAdd = YES;
    }
    return _tableView;
}

@end
