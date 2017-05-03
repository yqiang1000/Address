//
//  InviteViewController.m
//  通讯录Demo
//
//  Created by yeqiang on 2017/5/2.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "InviteViewController.h"
#import "AddressCell.h"

@interface InviteViewController () <UITableViewDelegate, UITableViewDataSource, AddressCellDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIImage *leftImage;

@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI {
    [self.view addSubview:self.tableView];
    [self updateSearchBar];
}

- (void)updateSearchBar {
//    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)];
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    if (searchField) {
        UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 7, 14, 14)];
        rightView.image = [UIImage imageNamed:@"ic-选择框单选"];
        rightView.contentMode = UIViewContentModeCenter;
        searchField.rightView = rightView;
        searchField.leftViewMode = UITextFieldViewModeAlways;
        
        
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 14.0f;
        searchField.textAlignment = NSTextAlignmentLeft;
        searchField.layer.masksToBounds = YES;
        [searchField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_searchBar.mas_left).offset(15);
            make.centerY.equalTo(_searchBar.mas_centerY);
        }];
    }
    
    // 修改UISearchBar右侧的取消按钮文字颜色
    for (id obj in [self.searchBar subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    // 修改文字颜色
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
                    // 修改按钮文字
                    [btn setTitle:@"取消" forState:UIControlStateNormal];
                }
            }
        }
    }
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
    return 10;
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

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0) {
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    
}

#pragma mark - public


#pragma mark - setter and getter 
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.searchBar;
    }
    return _tableView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = YES;
        [_searchBar setContentMode:UIViewContentModeLeft];
        _searchBar.placeholder = @"搜索好友或通过手机号邀请";
        [_searchBar setScopeBarBackgroundImage:[UIImage imageNamed:@"ic-选择框单选"]];//@"ic-搜索通讯录"]];
    }
    return _searchBar;
}

@end
