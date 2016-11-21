//
//  UIButton+Util.m
//  Baisibudejie
//
//  Created by qianfeng on 16/11/21.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "UIButton+Util.h"

@implementation UIButton (Util)

+ (UIButton *)createBtnTitle:(NSString *)title bgImageName:(NSString *)bgImageName highLightBgImageName:(NSString *)highLightBgImageName target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (bgImageName) {
        [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    if (highLightBgImageName) {
        [btn setBackgroundImage:[UIImage imageNamed:highLightBgImageName] forState:UIControlStateHighlighted];
    }
    if (target && action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}
@end
