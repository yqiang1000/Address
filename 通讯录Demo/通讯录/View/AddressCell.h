//
//  AddressCell.h
//  通讯录Demo
//
//  Created by yeqiang on 2017/3/10.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPPersonModel.h"

typedef NS_ENUM(NSInteger, HeaderType) {
    HeaderTypeAdd = 1,
    HeaderTypeNew = 2,
};

typedef NS_ENUM(NSInteger, AddressCellType) {
    AddressCellTypeDefault  = 0,
    AddressCellTypeInvite   = 1,
};

@protocol AddressCellDelegate <NSObject>

/** 状态按钮点击事件 */
- (void)addressCellDidSelected:(PPPersonModel *)model;
/** 邀请按钮点击事件 */
- (void)btnInviteSelected:(BOOL)selected model:(PPPersonModel *)model;

@end

@protocol AddressHeaderViewDelegate <NSObject>

- (void)addressHeaderViewSelected:(HeaderType)type;

@end

@protocol AddressSearchBarDelegate <NSObject>


@end

#pragma mark - AddressCell

@interface AddressCell : UITableViewCell <AddressCellDelegate>

@property (nonatomic, assign) id <AddressCellDelegate> addressCellDelegate;
@property (nonatomic, strong) PPPersonModel *model;
@property (nonatomic, assign) AddressStatues statues;
@property (nonatomic, assign) AddressCellType cellType;
@property (nonatomic, assign) BOOL isInvite;

- (void)loadDataWith:(PPPersonModel *)model;

@end

#pragma mark - ABCAddressHeader

@interface ABCAddressHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *title;

/** tableView头视图点击事件 */
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end

#pragma mark - AddressHeaderView

@interface AddressHeaderView : UIView <AddressHeaderViewDelegate>

@property (nonatomic, assign) id <AddressHeaderViewDelegate> delegate;
/** 设置新消息数量 */
- (void)setNewCount:(NSInteger)newCount;

@end

#pragma mark - AddressSearchBar

@interface AddressSearchBar : UIView

@property (nonatomic, assign) id <AddressSearchBarDelegate> delegate;

@end
