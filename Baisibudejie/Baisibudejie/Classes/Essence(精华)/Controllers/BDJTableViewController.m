//
//  BDJMenuViewController.m
//  Baisibudejie
//
//  Created by qianfeng on 16/11/23.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "BDJTableViewController.h"
#import "BDJEssenceModel.h"
#import "EssenceVideoCell.h"
#import "EssenceImageCell.h"
#import "EssenceTextCell.h"
#import "EssenceAudioCell.h"

@interface BDJTableViewController ()<UITableViewDelegate,UITableViewDataSource>
//表格
@property (nonatomic, strong)UITableView *tableView;
//数据
@property (nonatomic, strong)BDJEssenceModel *model;
//分页
@property (nonatomic, strong)NSNumber *np;

@end

@implementation BDJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];//创建表格
    self.np = @(0);//初始页码
    [self downloadListData];//下载数据
}

//创建表格
- (void)createTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //约束
    __weak typeof(self) weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstPage)];
    //上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNextPage)];
}
//下拉刷新
- (void)loadFirstPage {
    self.np = @(0);
    [self downloadListData];
}
//上拉加载更多
- (void)loadNextPage {
    self.np = self.model.info.np;
    [self downloadListData];
}

//下载列表数据
- (void)downloadListData {
    
    [ProgressHUD show:@"正在下载" Interaction:NO];
    
    //http://s.budejie.com/topic/list/jingxuan/41/bs0315-iphone-4.3/0-20.json
    NSString *urlString = [NSString stringWithFormat:@"%@bs0315-iphone-4.3/%@-20.json", self.url, self.np];
    NSLog(@"%@", urlString);
    [BDJDownloader downloadWithURLString:urlString success:^(NSData *data) {
        NSError *error = nil;
        BDJEssenceModel *model = [[BDJEssenceModel alloc] initWithData:data error: &error];
        if (error) {
            NSLog(@"%@", error);
        }else {
            //第一页
            if (self.np.integerValue == 0) {
                self.model = model;
            }else {
                //后面的页数，每次都用数组第一个元素的np，所以不能尾部追加
                NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:self.model.list];
                [tmpArray addObjectsFromArray:model.list];
                model.list = (NSArray<Optional,BDJEssenceDetail> *)tmpArray;
                self.model = model;
            }
            
            //刷新表格
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                
                //结束第三方库的刷新
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                [ProgressHUD showSuccess:@"下载成功"];
            });
        }
        
        
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
        [ProgressHUD showError:@"下载失败"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDJEssenceDetail *detail = self.model.list[indexPath.row];
    UITableViewCell *cell = nil;
    if ([detail.type isEqualToString:@"video"]) {
        //视频的cell
        cell = [EssenceVideoCell videoCellForTableView:tableView atIndexPath:indexPath withModel:detail];
    }else if ([detail.type isEqualToString:@"image"]) {
        cell = [EssenceImageCell imageCellForTableView:tableView atIndexPath:indexPath withModel:detail];
    }else if ([detail.type isEqualToString:@"text"]) {
        cell = [EssenceTextCell textCellForTableView:tableView atIndexPath:indexPath withModel:detail];
    }else if ([detail.type isEqualToString:@"audio"]) {
        cell = [EssenceAudioCell audioCellForTableView:tableView atIndexPath:indexPath withModel:detail];
    }else {
        cell = [[UITableViewCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDJEssenceDetail *detail = self.model.list[indexPath.row];
    return detail.cellHeight.floatValue;
}
@end

