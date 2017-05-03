//
//  MessageModel.h
//  通讯录Demo
//
//  Created by yeqiang on 2017/5/2.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MessageType) {
    MessageTypeStart   = 0,        //去上课
    MessageTypeFinish  = 1,        //已结束
};

@interface MessageModel : NSObject

@property (nonatomic, copy) NSString *headImage;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *yearStr;
@property (nonatomic, copy) NSString *dateStr;
@property (nonatomic, copy) NSString *hourStr;
@property (nonatomic, assign) MessageType type;

@end
