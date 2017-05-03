//
//  InviteView.m
//  通讯录Demo
//
//  Created by yeqiang on 2017/3/11.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "InviteView.h"

@interface InviteView ()

@property (nonatomic, strong) UIView *baseView;

@end

@implementation InviteView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGPoint point = [[touches anyObject] locationInView:self];
    point = [self.baseView.layer convertPoint:point fromLayer:self.layer];
    if (![self.baseView.layer containsPoint:point]) {
        if ([self.inviteViewDelegate respondsToSelector:@selector(inviteView:didSelectBtnType:)]) {
            [self.inviteViewDelegate inviteView:self didSelectBtnType:InviteTypeCancel];
        }
    }
}

- (void)setUI {
    
    [self addSubview:self.baseView];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectZero];
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectZero];
    lineView1.backgroundColor = [UIColor grayColor];
    lineView2.backgroundColor = [UIColor grayColor];
    [self.baseView addSubview:lineView1];
    [self.baseView addSubview:lineView2];
    
    UILabel *labText = [[UILabel alloc] initWithFrame:CGRectZero];
    labText.font = [UIFont systemFontOfSize:14];
    labText.text = @"您的好友还没有注册笔声\n您可以向TA发出短信邀请";
    labText.numberOfLines = 2;
    labText.textAlignment = NSTextAlignmentCenter;
    [self.baseView addSubview:labText];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectZero];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.baseView addSubview:btnCancel];
    btnCancel.tag = InviteTypeCancel;
    [btnCancel addTarget:self action:@selector(inviteViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnInvite = [[UIButton alloc] initWithFrame:CGRectZero];
    [btnInvite setTitle:@"发送邀请" forState:UIControlStateNormal];
    [btnInvite setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btnInvite.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.baseView addSubview:btnInvite];
    btnInvite.tag = InviteTypeInvite;
    [btnInvite addTarget:self action:@selector(inviteViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@225.0);
        make.height.equalTo(@135.0);
    }];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.baseView);
        make.right.equalTo(self.baseView);
        make.bottom.equalTo(self.baseView.mas_bottom).offset(-44);
        make.height.equalTo(@0.5);
    }];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom);
        make.centerX.bottom.equalTo(self.baseView);
        make.width.equalTo(@0.5);
    }];
    
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom);
        make.left.bottom.equalTo(self.baseView);
        make.right.equalTo(lineView2.mas_left);
    }];
    
    [btnInvite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom);
        make.right.bottom.equalTo(self.baseView);
        make.left.equalTo(lineView2.mas_right);
    }];
    
    [labText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top).offset(28);
        make.right.left.equalTo(self.baseView);
        make.bottom.equalTo(lineView1.mas_top).offset(-25);
    }];
    
}

- (void)inviteViewBtnAction:(UIButton *)sender {
    if ([self.inviteViewDelegate respondsToSelector:@selector(inviteView:didSelectBtnType:)]) {
        [self.inviteViewDelegate inviteView:self didSelectBtnType:(InviteType)sender.tag];
    }
}

- (UIView *)baseView {
    if (!_baseView) {
        _baseView = [[UIView alloc] initWithFrame:CGRectZero];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.layer.cornerRadius = 6.0;
        _baseView.layer.masksToBounds = YES;
    }
    return _baseView;
}

@end
