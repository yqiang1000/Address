//
//  MessageModel.m
//  通讯录Demo
//
//  Created by yeqiang on 2017/5/2.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _headImage = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1873970797,995040542&fm=111&gp=0.jpg";
        _name = @"张天师";
        _message = @"邀请你来上课";
        _className = @"斯坦福公开课";
        _yearStr = @"2017/02/15";
        _dateStr = @"02-15";
        _hourStr = @"上午11:35";
        _type = arc4random()%2;
    }
    return self;
}

@end
