//
//  EssenceImageCell.h
//  Baisibudejie
//
//  Created by qianfeng on 16/11/22.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDJEssenceDetail;
@interface EssenceImageCell : UITableViewCell

//数据
@property (nonatomic, strong)BDJEssenceDetail *detailModel;

//创建cell的类方法
+ (EssenceImageCell *)imageCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withModel:(BDJEssenceDetail *)detailModel;


@end
