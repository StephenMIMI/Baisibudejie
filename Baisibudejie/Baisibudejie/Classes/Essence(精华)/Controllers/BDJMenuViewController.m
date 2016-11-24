//
//  BDJMenuViewController.m
//  Baisibudejie
//
//  Created by qianfeng on 16/11/23.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "BDJMenuViewController.h"
#import "BDJTableViewController.h"
#import "BDJMenu.h"
#import "BDJMenuView.h"

@interface BDJMenuViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource, BDJMenuViewDelegate>
//视图控制器数组
@property (nonatomic, strong)NSMutableArray *ctrlArray;
//分页视图控制器
@property (nonatomic, strong)UIPageViewController *pageCtrl;

//当前显示的视图控制器的序号
@property (nonatomic, assign)NSInteger curPageIndex;
//菜单视图
@property (nonatomic, strong)BDJMenuView *menuView;
@end

@implementation BDJMenuViewController

//懒加载初始化
- (NSMutableArray *)ctrlArray {
    if (nil == _ctrlArray) {
        _ctrlArray = [NSMutableArray array];
    }
    return _ctrlArray;
}

- (void)setSubMenus:(NSArray *)subMenus {
    _subMenus = subMenus;
    //循环创建视图控制器
    for (BDJSubmenu *subMenu in subMenus) {
        BDJTableViewController *ctrl = [[BDJTableViewController alloc] init];
        ctrl.url = subMenu.url;
        ctrl.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0f green:arc4random_uniform(256)/255.0f blue:arc4random_uniform(256)/255.0f alpha:1.0];
        [self.ctrlArray addObject:ctrl];
    }
    //创建分页控制器
    [self createPageCtrl];
    //创建导航
    [self createMenu];
}

//创建导航
- (void)createMenu {
    BDJMenuView *menuView = [[BDJMenuView alloc] initWithItems:self.subMenus rightIcon:self.rightImageName rightSelectIcon:self.rightHLImageName];
    self.menuView = menuView;
    self.navigationItem.titleView = menuView;
    //设置代理
    menuView.delegate = self;
    //约束
    [menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.navigationController.view);
        make.top.equalTo(self.navigationController.view).offset(20);
        make.height.mas_equalTo(44);
    }];
}

//创建分页控制器
- (void)createPageCtrl {
    UIPageViewController *pageCtrl = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [pageCtrl setViewControllers:@[[self.ctrlArray firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    //设置代理
    pageCtrl.delegate = self;
    pageCtrl.dataSource = self;
    [self.view addSubview:pageCtrl.view];
    self.pageCtrl = pageCtrl;
    
    //约束
    [pageCtrl.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewController的代理
//返回向后滑动时显示的视图控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    //1.当前的序号
    NSInteger curIndex = [self.ctrlArray indexOfObject:viewController];
    //2.获取后面的视图控制器
    if (curIndex+1 >= self.ctrlArray.count) {
        return nil;
    }else {
        return self.ctrlArray[curIndex+1];
    }
}
//返回向前滑动显示的视图控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    //1.当前的序号
    NSInteger curIndex = [self.ctrlArray indexOfObject:viewController];
    //2.获取前面的视图控制器
    if (curIndex-1 < 0) {
        return nil;
    }else {
        return self.ctrlArray[curIndex-1];
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    //获取序号
    UIViewController *lastCtrl = [pendingViewControllers lastObject];
    NSInteger index = [self.ctrlArray indexOfObject:lastCtrl];
    self.curPageIndex = index;
    self.menuView.selectIndex = self.curPageIndex;
}

#pragma mark - BDJMenuView的代理
- (void)menuView:(BDJMenuView *)menuView didClickBtnAtIndex:(NSInteger)index {
    //获取视图控制器
    UIViewController *vc = self.ctrlArray[index];
    UIPageViewControllerNavigationDirection dir = UIPageViewControllerNavigationDirectionForward;
    if (index < self.curPageIndex) {
        dir = UIPageViewControllerNavigationDirectionReverse;
    }
    self.curPageIndex = index;
    [self.pageCtrl setViewControllers:@[vc] direction:dir animated:YES completion:nil];
}

- (void)menuView:(BDJMenuView *)menuView didClickRightBtn:(MenuType)type {
    NSLog(@"点击了右边的按钮");
}

@end
