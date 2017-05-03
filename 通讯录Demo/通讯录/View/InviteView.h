//
//  InviteView.h
//  通讯录Demo
//
//  Created by yeqiang on 2017/3/11.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InviteView;

typedef enum InviteType{
    InviteTypeCancel = 1,
    InviteTypeInvite = 2,
}InviteType;

@protocol InviteViewDelegate <NSObject>

- (void)inviteView:(InviteView *)inviteView didSelectBtnType:(InviteType)type;

@end

@interface InviteView : UIView <InviteViewDelegate>

@property (nonatomic, assign) id <InviteViewDelegate> inviteViewDelegate;

@end
