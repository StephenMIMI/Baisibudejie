//
//  BDJMenuView.h
//  Baisibudejie
//
//  Created by qianfeng on 16/11/24.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuType) {
    MenuTypeEssence = 1 << 0, //精华
    MenuTypeNews = 1 << 1      //最新
};

@class BDJMenuView;

@protocol BDJMenuViewDelegate <NSObject>
//点击了第几个按钮
- (void)menuView:(BDJMenuView *)menuView didClickBtnAtIndex:(NSInteger)index;

//点击右边按钮
- (void) menuView:(BDJMenuView *)menuView didClickRightBtn:(MenuType)type;

@end

@class BDJSubmenu;
@interface BDJMenuView : UIView

//初始化方法
/*
@para array: 菜单数据的数组
@para iconName: 右边按钮上面的图片
 */

- (instancetype)initWithItems:(NSArray *)array rightIcon:(NSString *)iconName rightSelectIcon:(NSString *)selectIconName;
//当前选中的按钮
@property (nonatomic, assign)NSInteger selectIndex;
//枚举属性
@property (nonatomic, assign)MenuType type;
//代理属性
@property (nonatomic, weak)id<BDJMenuViewDelegate> delegate;


@end


//菜单按钮
@interface BDJMenuButton : UIControl

- (instancetype)initWithTitle:(NSString *)title;
//是否选中
@property(nonatomic, assign)BOOL clicked;
//按钮的序号
@property(nonatomic, assign)NSInteger btnIndex;

@end
