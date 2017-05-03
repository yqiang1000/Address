//
//  MessageCell.m
//  通讯录Demo
//
//  Created by yeqiang on 2017/5/2.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell ()

@property (nonatomic, strong) MessageModel *model;

@end

@implementation MessageCell

#pragma mark - lifeCycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.headImage];
    [self.contentView addSubview:self.labName];
    [self.contentView addSubview:self.labMessage];
    [self.contentView addSubview:self.labClass];
    [self.contentView addSubview:self.labYear];
    [self.contentView addSubview:self.labDate];
    [self.contentView addSubview:self.labHour];
    [self.contentView addSubview:self.btnState];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectZero];
    line1.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:line1];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectZero];
    line2.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:line2];
    
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(60);
        make.height.equalTo(@0.5);
        make.left.equalTo(self.headImage.mas_right).offset(12);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(60);
        make.height.equalTo(@0.5);
        make.left.right.equalTo(self.contentView);
    }];
    
    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(12);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    
    [self.labMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labName.mas_left);
        make.top.equalTo(self.labName.mas_bottom).offset(6);
        make.bottom.equalTo(line1.mas_top).offset(-10);
    }];
    
    [self.labDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labName.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    [self.labClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labName.mas_left);
        make.top.equalTo(line1.mas_bottom).offset(12);
    }];
    
    [self.labYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labName.mas_left);
        make.top.equalTo(self.labClass.mas_bottom).offset(6);
        make.bottom.equalTo(line2.mas_top).offset(-15);
    }];
    
    [self.labHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labYear.mas_centerY);
        make.left.equalTo(self.labYear.mas_right).offset(12);
    }];
    
    [self.btnState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.bottom.equalTo(line2.mas_top).offset(-15);
        make.width.equalTo(@54);
        make.height.equalTo(@29);
    }];
    
}

#pragma mark - public
- (void)loadData:(MessageModel *)model {
    if (_model != model) {
        _model = model;
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:_model.headImage]];
        self.labName.text = _model.name;
        self.labMessage.text = _model.message;
        self.labDate.text = _model.dateStr;
        self.labClass.text = _model.className;
        self.labYear.text = _model.yearStr;
        self.labHour.text = _model.hourStr;
        if (_model.type == MessageTypeStart) {
            [self.btnState setTitle:@"去上课" forState:UIControlStateNormal];
            self.btnState.backgroundColor = [UIColor orangeColor];
            self.btnState.tag = MessageTypeStart;
        } else if (_model.type == MessageTypeFinish) {
            [self.btnState setTitle:@"已结束" forState:UIControlStateNormal];
            self.btnState.backgroundColor = [UIColor lightGrayColor];
            self.btnState.tag = MessageTypeFinish;
        }
    }
}

- (void)btnClick:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(messageCellSelected:type:)]) {
        [_delegate messageCellSelected:_model type:sender.tag];
    }
}

#pragma mark - setter and getter
- (UIImageView *)headImage {
    if (!_headImage) {
        _headImage = [[UIImageView alloc] init];
        _headImage.layer.cornerRadius = 20.0;
        _headImage.clipsToBounds = YES;
    }
    return _headImage;
}

- (UILabel *)labName {
    if (!_labName) {
        _labName = [[UILabel alloc] initWithFrame:CGRectZero];
        _labName.font = [UIFont systemFontOfSize:15];
        _labName.textColor = [UIColor blackColor];
    }
    return _labName;
}

- (UILabel *)labMessage {
    if (!_labMessage) {
        _labMessage = [[UILabel alloc] initWithFrame:CGRectZero];
        _labMessage.font = [UIFont systemFontOfSize:12];
        _labMessage.textColor = [UIColor lightGrayColor];
    }
    return _labMessage;
}

- (UILabel *)labClass {
    if (!_labClass) {
        _labClass = [[UILabel alloc] initWithFrame:CGRectZero];
        _labClass.font = [UIFont systemFontOfSize:14];
        _labClass.textColor = [UIColor blackColor];
    }
    return _labClass;
}

- (UILabel *)labYear {
    if (!_labYear) {
        _labYear = [[UILabel alloc] initWithFrame:CGRectZero];
        _labYear.font = [UIFont systemFontOfSize:12];
        _labYear.textColor = [UIColor blackColor];
    }
    return _labYear;
}

- (UILabel *)labDate {
    if (!_labDate) {
        _labDate = [[UILabel alloc] initWithFrame:CGRectZero];
        _labDate.font = [UIFont systemFontOfSize:12];
        _labDate.textColor = [UIColor lightGrayColor];
    }
    return _labDate;
}

- (UILabel *)labHour {
    if (!_labHour) {
        _labHour = [[UILabel alloc] initWithFrame:CGRectZero];
        _labHour.font = [UIFont systemFontOfSize:12];
        _labHour.textColor = [UIColor blackColor];
    }
    return _labHour;
}

- (UIButton *)btnState {
    if (!_btnState) {
        _btnState = [[UIButton alloc] initWithFrame:CGRectZero];
        [_btnState setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnState.titleLabel.font = [UIFont systemFontOfSize:12];
        _btnState.layer.cornerRadius = 4.0;
        _btnState.clipsToBounds = YES;
        [_btnState addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnState;
}

@end
