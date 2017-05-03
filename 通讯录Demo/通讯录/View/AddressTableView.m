
//
//  AddressTableView.m
//  通讯录Demo
//
//  Created by yeqiang on 2017/4/28.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "AddressTableView.h"
#import "MobileFirendsViewCtrl.h"
#import "InviteView.h"

@interface AddressTableView ()  <UITableViewDelegate, UITableViewDataSource, AddressCellDelegate>

@property (nonatomic, strong) NSMutableDictionary *contactPeopleDict;
@property (nonatomic, strong) NSMutableArray *keys;

@end

@implementation AddressTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self refreshData];
    }
    return self;
}

#pragma mark - public
- (void)refreshData {
    [PPGetAddressBook getOrderAddressBook:^(NSDictionary<NSString *,NSArray *> *addressBookDict, NSArray *nameKeys) {
        self.contactPeopleDict = [addressBookDict mutableCopy];
        self.keys = [nameKeys mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
    } authorizationFailure:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请在iPhone的“设置-隐私-通讯录”选项中，允许PPAddressBook访问您的通讯录"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = self.keys[section];
    NSArray *arr = [self.contactPeopleDict objectForKey:key];
    return arr.count;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"firendsCell";
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[AddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.addressCellDelegate = self;
    }
    NSString *key = self.keys[indexPath.section];
    PPPersonModel *model = [[self.contactPeopleDict objectForKey:key] objectAtIndex:indexPath.row];
    
    if (_showAdd) {
        int x = arc4random() % 6 + 1;
        model.statues = x;
    } else {
        model.statues = kAddressStatuesNone;
    }
    cell.cellType = self.cellType;
    [cell loadDataWith:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = self.keys[indexPath.section];
    PPPersonModel *model = [[self.contactPeopleDict objectForKey:key] objectAtIndex:indexPath.row];
    if (_addressDelegate && [_addressDelegate respondsToSelector:@selector(addressTableView:didSelectRowAtIndexPath:model:)]) {
        [_addressDelegate addressTableView:self didSelectRowAtIndexPath:indexPath model:model];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return _canEdit;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"删除");
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ABCAddressHeader *header = [ABCAddressHeader headerViewWithTableView:tableView];
    header.title = self.keys[section];
    return header;
}

//右侧的索引
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_showIndex) {
        NSMutableArray *array = [self.keys mutableCopy];
        return array;
    } else {
        return nil;
    }
}

#pragma mark - AddressCellDelegate
- (void)addressCellDidSelected:(PPPersonModel *)model {
    if (_addressDelegate && [_addressDelegate respondsToSelector:@selector(btnStateDidSelected:)]) {
        [_addressDelegate btnStateDidSelected:model];
    }
}

#pragma mark - setter and getter
- (NSMutableDictionary *)contactPeopleDict {
    if (!_contactPeopleDict) {
        _contactPeopleDict = [NSMutableDictionary new];
    }
    return _contactPeopleDict;
}

- (NSMutableArray *)keys {
    if (!_keys) {
        _keys = [NSMutableArray new];
    }
    return _keys;
}

- (void)setCanEdit:(BOOL)canEdit {
    _canEdit = canEdit;
}

- (void)setShowIndex:(BOOL)showIndex {
    _showIndex = showIndex;
}

- (void)setShowAdd:(BOOL)showAdd {
    _showAdd = showAdd;
}

- (void)setCellType:(AddressCellType)cellType {
    _cellType = cellType;
}

@end
