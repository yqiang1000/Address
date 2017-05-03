//
//  MainTabBarController.m
//  通讯录Demo
//
//  Created by yeqiang on 2017/3/1.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNaviController.h"

@interface MainTabBarController ()

//@property (nonatomic, strong) NSArray *nameArray;
//@property (nonatomic, strong) NSMutableArray *vcArray;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *nameArray = @[@"First", @"MyNews", @"Third", @"Forth"];
    NSArray *colorArray = @[[UIColor whiteColor], [UIColor orangeColor], [UIColor blueColor], [UIColor redColor]];
    NSMutableArray *vcArray = [NSMutableArray new];
    NSArray *imageNameArray = @[@"ic-开课录制",@"ic-热门课程", @"ic-浏览记录", @"ic-我的收藏"];
    NSArray *imageSelect = @[@"ic-开课录制选中",@"ic-热门课程选中", @"ic-浏览记录选中", @"ic-我的收藏选中"];
    
    for (int i = 0; i < nameArray.count; i++) {
        NSString *classStr = [NSString stringWithFormat:@"%@ViewController", nameArray[i]];
        Class class = NSClassFromString(classStr);
        UIViewController *viewController = [[class alloc] init];
        viewController.view.backgroundColor = colorArray[i];
        BaseNaviController *navi = [[BaseNaviController alloc] initWithRootViewController:viewController];
        viewController.title = nameArray[i];
        [vcArray addObject:navi];
    }
    
    self.viewControllers = vcArray;
    for (int i = 0; i < nameArray.count; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        item.title = nameArray[i];
        [item setImage:[UIImage imageNamed:imageNameArray[i]]];
        [item setSelectedImage:[UIImage imageNamed:imageSelect[i]]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
