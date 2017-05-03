
//
//  MyNewsViewController.m
//  通讯录Demo
//
//  Created by yeqiang on 2017/3/11.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "MyNewsViewController.h"
#import "AFNetworking.h"

@interface MyNewsViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation MyNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.textField];
    self.textField.attributedPlaceholder;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
    }
    return _textField;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
