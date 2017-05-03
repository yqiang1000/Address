//
//  InviteViewController.m
//  通讯录Demo
//
//  Created by yeqiang on 2017/5/2.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "InviteViewController.h"
#import "AddressCell.h"
#import "SearchViewCtrl.h"

@interface InviteViewController () <UITableViewDelegate, UITableViewDataSource, AddressCellDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *searchBar;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIImageView *searchIcon;
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UITableView *resultTableView;

@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginediting:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [self setUI];
    [self setAutoFrame];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI {
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.searchBar;
    [_searchBar addSubview:self.btnCancel];
    [_searchBar addSubview:self.searchView];
    [_searchBar addSubview:self.searchIcon];
    [_searchBar addSubview:self.searchField];
}

- (void)setAutoFrame {
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchBar.mas_centerY);
        make.height.equalTo(@28);
        make.left.equalTo(self.searchBar.mas_left).offset(15);
    }];
    
    [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchBar.mas_centerY);
        make.left.equalTo(self.searchView.mas_right).offset(12);
        make.right.equalTo(self.searchBar.mas_right).offset(-15);
        make.width.equalTo(@30);
    }];
    
    [self.searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchBar.mas_centerY);
        make.left.equalTo(self.searchView.mas_left).offset(14);
        make.height.equalTo(@14);
        make.width.equalTo(@14);
    }];
    
    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchBar.mas_centerY);
        make.left.equalTo(self.searchIcon.mas_right).offset(6);
        make.right.equalTo(self.searchView.mas_right).offset(-14);
        make.height.equalTo(@28);
    }];
}

#pragma mark - AddressCellDelegate

- (void)btnInviteSelected:(BOOL)selected model:(PPPersonModel *)model {
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"inviteCell";
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.addressCellDelegate = self;
    }
    PPPersonModel *model = [[PPPersonModel alloc] init];
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1873970797,995040542&fm=111&gp=0.jpg"]];
    model.headerImage = imageView.image;
    model.name = @"张天师";
    model.isInvite = arc4random()%2;
    model.statues = AddressCellTypeDefault;
    model.mobileArray = nil;
    cell.cellType = AddressCellTypeInvite;
    [cell loadDataWith:model];
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)btnClick:(UIButton *)sender {
    NSLog(@"显示");
    [self.searchField endEditing:YES];
    self.searchField.text = nil;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)beginediting:(UITapGestureRecognizer *)tap {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (_resultTableView) {
        _resultTableView = [UITableView alloc] initWithFrame:<#(CGRect)#> style:<#(UITableViewStyle)#>
    }
}

#pragma mark - public


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


- (UIView *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _searchBar.backgroundColor = [UIColor lightGrayColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = [UIColor blackColor];
        [_searchBar addSubview:lineView];
    }
    return _searchBar;
}

- (UIView *)searchView {
    if (!_searchView) {
        _searchView = [[UIView alloc] initWithFrame:CGRectZero];
        _searchView.backgroundColor = [UIColor whiteColor];
        _searchView.layer.cornerRadius = 14.0;
        _searchView.layer.borderWidth = 0.5;
        _searchView.layer.borderColor = [UIColor blackColor].CGColor;
        _searchView.clipsToBounds = YES;
    }
    return _searchView;
}

- (UIImageView *)searchIcon {
    if (!_searchIcon) {
        _searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic-搜索通讯录"]];
    }
    return _searchIcon;
}

- (UITextField *)searchField {
    if (!_searchField) {
        _searchField = [[UITextField alloc] initWithFrame:CGRectZero];
        _searchField.borderStyle = UITextBorderStyleNone;
        _searchField.placeholder = @"搜索好友或通过手机号邀请";
        _searchField.font = [UIFont systemFontOfSize:12.0];
    }
    return _searchField;
}

- (UIButton *)btnCancel {
    if (!_btnCancel) {
        _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCancel addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_btnCancel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _btnCancel.titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _btnCancel;
}

@end
