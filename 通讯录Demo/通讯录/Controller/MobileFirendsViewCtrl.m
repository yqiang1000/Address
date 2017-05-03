//
//  MobileFirendsViewCtrl.m
//  通讯录Demo
//
//  Created by yeqiang on 2017/4/28.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "MobileFirendsViewCtrl.h"
#import "AddressTableView.h"
#import "InviteView.h"
#import <MessageUI/MessageUI.h>

@interface MobileFirendsViewCtrl () <AddressTableViewDelegate, InviteViewDelegate>

@property (nonatomic, strong) AddressTableView *tableView;
@property (nonatomic, strong) PPPersonModel *selectedModel;

@end

@implementation MobileFirendsViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma AddressTableViewDelegate

- (void)addressTableView:(AddressTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath model:(PPPersonModel *)model {
    NSLog(@"\nname:%@   number:%@", model.name, model.mobileArray);
}

- (void)btnStateDidSelected:(PPPersonModel *)model {
    NSLog(@"\nmodel:%@\nstate:%d", model, model.statues);
    self.selectedModel = model;
    if (model.statues == kAddressStatuesAdd) {
        NSLog(@"添加好友");
        InviteView *inviteView = [[InviteView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        inviteView.inviteViewDelegate = self;
        inviteView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [[UIApplication sharedApplication].keyWindow addSubview:inviteView];
        [UIView animateWithDuration:0.35 animations:^{
            inviteView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
        
    } else if (model.statues == kAddressStatuesAccept) {
        NSLog(@"接受");
    }
}

#pragma mark - InviteViewDelegate
- (void)inviteView:(InviteView *)inviteView didSelectBtnType:(InviteType)type {
    
    [UIView animateWithDuration:0.35 animations:^{
        inviteView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [inviteView removeFromSuperview];
        if (type == InviteTypeInvite) {
            if (self.selectedModel.mobileArray > 0) {
                NSArray *array = self.selectedModel.mobileArray;
                [self showMessageView:[NSArray arrayWithObject:array[0]] title:@"hello" body:@"你好，我正在笔声上课。希望能邀请你一起参与课堂讨论，请点击https://itunes.apple.com/cn/app/id1169271807下载应用，搜索课程ID：123-456-789"];
            }
        } else if (type == InviteTypeCancel){
            return;
        }
    }];
}

-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body {
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.title = title;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            NSLog(@"send success");
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            NSLog(@"send failed");
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            NSLog(@"send canceled");
            break;
        default:
            break;
    }
}

#pragma mark - setter and getter

- (AddressTableView *)tableView {
    if (!_tableView) {
        _tableView = [[AddressTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.addressDelegate = self;
        _tableView.showIndex = YES;
        _tableView.canEdit = YES;
        _tableView.showAdd = YES;
        _tableView.cellType = AddressCellTypeDefault;
    }
    return _tableView;
}

@end
