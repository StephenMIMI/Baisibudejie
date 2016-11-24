//
//  BDJMenuView.m
//  Baisibudejie
//
//  Created by qianfeng on 16/11/24.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "BDJMenuView.h"
#import "BDJMenu.h"
#define kContainerViewTag (100)

@interface BDJMenuView()
//滚动视图
@property (nonatomic, strong)UIScrollView *scrollView;
//下划线
@property (nonatomic, strong)UIView *lineView;
@end

@implementation BDJMenuView

- (instancetype)initWithItems:(NSArray *)array rightIcon:(NSString *)iconName rightSelectIcon:(NSString *)selectIconName {
    if (self = [super init]) {
    
        //1.左边的滚动视图
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 60));
        }];
        
        //1.1循环创建按钮
        //1.1.1容器视图
        UIView *containerView = [[UIView alloc] init];
        containerView.tag = kContainerViewTag;
        [self.scrollView addSubview:containerView];
        
        //约束
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView);
            make.height.equalTo(self.scrollView);
        }];
        
        //1.1.2 按钮
        //按钮的宽度
        CGFloat btnW = 60;
        //上一次添加的子视图
        UIView *lastView = nil;
        //按钮的序号
        NSInteger i = 0;
        for (BDJSubmenu *subMenu in array) {
            BDJMenuButton *btn = [[BDJMenuButton alloc] initWithTitle:subMenu.name];
            //存储数据
            btn.btnIndex = i;
            if (i == 0) {
                btn.clicked = YES;
            }
            [containerView addSubview:btn];
            //点击事件
            [btn addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
            
            //约束
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView);
                make.width.mas_equalTo(btnW);
                if (lastView == nil) {
                    make.left.equalTo(containerView);
                }else {
                    make.left.equalTo(lastView.mas_right);
                }
            }];
            lastView = btn;
            i++;
        }
        //1.1.3 更新容器的约束
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastView);
        }];
        
        //2.右边的按钮
        UIButton *btn = [UIButton createBtnTitle:nil bgImageName:iconName highLightBgImageName:selectIconName target:self action:@selector(clickRight)];
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(4);
            make.right.equalTo(self).offset(-4);
            make.height.width.mas_equalTo(36);
        }];
        
        //3.下划线
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self.scrollView);
            make.width.mas_equalTo(btnW);
            make.height.mas_equalTo(2);
        }];

    }
    return self;
}

//切换按钮的选中状态
- (void)setSelectIndex:(NSInteger)selectIndex {
    
    if (_selectIndex != selectIndex) {
       
        BDJMenuButton *lastBtn = nil;
        BDJMenuButton *curBtn = nil;
        
        UIView *containerView = [self.scrollView viewWithTag:kContainerViewTag];
        for (BDJMenuButton *tmpBtn in containerView.subviews) {
            if (tmpBtn.btnIndex == selectIndex) {
                curBtn = tmpBtn;
            }else if (tmpBtn.btnIndex == _selectIndex) {
                lastBtn = tmpBtn;
            }
        }
        
        //1.取消之前选中的按钮
        lastBtn.clicked = NO;
        curBtn.clicked = YES;
        
        //2.选中当前按钮
         _selectIndex = selectIndex;
        
        //3.修改下划线位置
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(curBtn);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(2);
        }];
        
        //4.将当前选中的按钮尽可能显示在中间
        CGFloat x = CGRectGetMidX(curBtn.frame) - self.scrollView.bounds.size.width/2;
        //4.1 左边不能越界
        if (x<0) {
            x =0;
        }
        if (x > self.scrollView.contentSize.width - self.scrollView.bounds.size.width) {
            x = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
        }
        self.scrollView.contentOffset = CGPointMake(x, 0);
    }

}

//点击菜单按钮
- (void)clickMenu:(BDJMenuButton *)btn {
    //1.切换按钮的选中状态
    self.selectIndex = btn.btnIndex;
    //2.切换对应的界面
    [self.delegate menuView:self didClickBtnAtIndex:self.selectIndex];
}

//点击右边按钮
- (void)clickRight {

}

@end

@implementation BDJMenuButton{
    //文字
    UILabel *_titleLabel;
}

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        //创建文字视图
        _titleLabel = [UILabel createLabel:title textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:17]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

//切换选中状态
- (void)setClicked:(BOOL)clicked {
    _clicked = clicked;
    
    if (_clicked) {
        _titleLabel.textColor = [UIColor redColor];
    }else {
        _titleLabel.textColor = [UIColor grayColor];
    }
}

@end
