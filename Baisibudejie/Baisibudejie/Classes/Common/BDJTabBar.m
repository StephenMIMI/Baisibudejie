//
//  BDJTabBar.m
//  Baisibudejie
//
//  Created by qianfeng on 16/11/21.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "BDJTabBar.h"

@implementation BDJTabBar


//重新实现初始化方法
- (instancetype)init {
    if (self = [super init]) {
        UIButton *addBtn = [UIButton createBtnTitle:nil bgImageName:@"tabBar_publish_icon" highLightBgImageName:@"tabBar_publish_click_icon" target:self action:@selector(publishAction)];
        [self addSubview:addBtn];
    }
    return self;
}

- (void)publishAction {
    NSLog(@"发布。。。");
}

//在当前对象的子视图重新布局的时候调用
/*在什么时候会重新布局
 1.视图显示到父视图上面的时候
 2.手动调用了视图对象的layoutIfNeed方法
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    //修改按钮的位置
    //注意：这里不能使用约束的方式修改
    CGFloat btnW = kScreenWidth/5;
    
    //遍历系统UITabBarButton的序号
    NSInteger index = 0;
    for (UIView *tmpView in self.subviews) {
        NSLog(@"%@", tmpView);
        if ([tmpView isKindOfClass:[UIButton class]]) {
            //tmpView.frame = CGRectMake(btnW*2, 4, btnW, 40);
            tmpView.center = CGPointMake(kScreenWidth/2, 49.0f/2);
            tmpView.size = CGSizeMake(40, 40);
        }else if ([tmpView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            tmpView.width = btnW;
            if (index >= 2) {
                tmpView.x = (index+1)*btnW;
            }else {
                tmpView.x = index*btnW;
            }
            index++;
        }
        
    }
    
}
@end
