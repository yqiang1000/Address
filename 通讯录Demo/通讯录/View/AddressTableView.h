//
//  AddressTableView.h
//  通讯录Demo
//
//  Created by yeqiang on 2017/4/28.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPGetAddressBook.h"
#import "AddressCell.h"

@class AddressTableView;

@protocol AddressTableViewDelegate <NSObject>

- (void)addressTableView:(AddressTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath model:(PPPersonModel *)model;
- (void)btnStateDidSelected:(PPPersonModel *)model;

@end

@interface AddressTableView : UITableView

@property (nonatomic, assign) id <AddressTableViewDelegate> addressDelegate;
@property (nonatomic, assign) BOOL showIndex;           //是否显示索引
@property (nonatomic, assign) BOOL canEdit;             //是否允许编辑
@property (nonatomic, assign) BOOL showAdd;             //是否添加好友
@property (nonatomic, assign) AddressCellType cellType; //cell类型


- (void)refreshData;

@end
