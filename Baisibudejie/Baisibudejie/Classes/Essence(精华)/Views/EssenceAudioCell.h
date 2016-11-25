//
//  EssenceAudioCell
//  Baisibudejie
//
//  Created by qianfeng on 16/11/22.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDJEssenceDetail;
@interface EssenceAudioCell : UITableViewCell

//数据
@property (nonatomic, strong)BDJEssenceDetail *detailModel;

//创建cell的类方法
+ (EssenceAudioCell *)audioCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withModel:(BDJEssenceDetail *)detailModel;


@end
