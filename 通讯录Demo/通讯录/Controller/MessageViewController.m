//
//  MessageViewController.m
//  通讯录Demo
//
//  Created by yeqiang on 2017/5/2.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"

@interface MessageViewController () <UITableViewDelegate, UITableViewDataSource, MessageCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 121;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"myMessageCell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    MessageModel *model = [[MessageModel alloc] init];
    [cell loadData:model];
    return cell;
}

#pragma mark - MessageCellDelegate
- (void)messageCellSelected:(MessageModel *)model type:(MessageType)type {
    NSLog(@"\nmodel:%@\ntype:%ld", model, (long)type);
}

#pragma mark - setter and getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
