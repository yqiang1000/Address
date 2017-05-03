//
//  MessageCell.h
//  通讯录Demo
//
//  Created by yeqiang on 2017/5/2.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@protocol MessageCellDelegate <NSObject>

- (void)messageCellSelected:(MessageModel *)model type:(MessageType)type;

@end

@interface MessageCell : UITableViewCell <MessageCellDelegate>

@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *labName;
@property (nonatomic, strong) UILabel *labMessage;
@property (nonatomic, strong) UILabel *labClass;
@property (nonatomic, strong) UILabel *labYear;
@property (nonatomic, strong) UILabel *labDate;
@property (nonatomic, strong) UILabel *labHour;
@property (nonatomic, strong) UIButton *btnState;

@property (nonatomic, weak) id <MessageCellDelegate> delegate;

- (void)loadData:(MessageModel *)model;

@end
