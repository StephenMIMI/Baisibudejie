//
//  UILabel+Util.m
//  Baisibudejie
//
//  Created by qianfeng on 16/11/24.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "UILabel+Util.h"

@implementation UILabel (Util)

+ (UILabel *)createLabel:(NSString *)title textColor:(UIColor *)color font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    if (title) {
        label.text = title;
    }
    if (color) {
        label.textColor = color;
    }
    if (font) {
        label.font = font;
    }
    return label;
}
@end
