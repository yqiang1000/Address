//
//  AddressViewController.m
//  通讯录Demo
//
//  Created by yeqiang on 2017/3/1.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressTableView.h"
#import "MobileFirendsViewCtrl.h"
#import "NewFirendsViewCtrl.h"

@interface AddressViewController () <UITableViewDelegate, UITableViewDataSource, AddressTableViewDelegate, AddressHeaderViewDelegate>

@property (nonatomic, strong) AddressTableView *tableView;
@property (nonatomic, strong) AddressHeaderView *headerView;

@end

@implementation AddressViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI {
    [self.view addSubview:self.tableView];
    [self.headerView setNewCount:arc4random() % 1000];
}

#pragma AddressTableViewDelegate

- (void)addressTableView:(AddressTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath model:(PPPersonModel *)model {
    NSLog(@"\nname:%@   number:%@", model.name, model.mobileArray);
}

#pragma mark - AddressHeaderViewDelegate
- (void)addressHeaderViewSelected:(HeaderType)type {
    BaseViewController *firendVC;
    if (type == HeaderTypeAdd) {
        firendVC = [[MobileFirendsViewCtrl alloc] init];
        firendVC.title = @"手机联系人";
        [self.navigationController pushViewController:firendVC animated:YES];
    } else if (type == HeaderTypeNew) {
        firendVC = [[NewFirendsViewCtrl alloc] init];
        firendVC.title = @"新的朋友";
        [self.navigationController pushViewController:firendVC animated:YES];
    }
}

#pragma mark - setter and getter

- (AddressTableView *)tableView {
    if (!_tableView) {
        _tableView = [[AddressTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.addressDelegate = self;
        _tableView.showIndex = NO;
        _tableView.canEdit = NO;
        _tableView.showAdd = NO;
        _tableView.cellType = AddressCellTypeDefault;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (AddressHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[AddressHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54*2+4)];
        _headerView.backgroundColor = [UIColor orangeColor];
        _headerView.delegate = self;
    }
    return _headerView;
}

@end
