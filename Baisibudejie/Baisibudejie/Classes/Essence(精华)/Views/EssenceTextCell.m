//
//  EssenceTextCell.m
//  Baisibudejie
//
//  Created by qianfeng on 16/11/22.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "EssenceTextCell.h"
#import "BDJEssenceModel.h"

@interface EssenceTextCell()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

//图片的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewHCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewYCons;

@end

@implementation EssenceTextCell

- (void)setDetailModel:(BDJEssenceDetail *)detailModel {
    _detailModel = detailModel;
    
    //1.用户图标
    NSString *headString = [detailModel.u.header firstObject];
    NSURL *url = [NSURL URLWithString:headString];
    [self.userImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.userImageView.layer.cornerRadius = 15;
    self.userImageView.layer.masksToBounds = YES;
    //2.用户名
    self.userNameLabel.text = detailModel.u.name;
    //3.时间
    self.passTimeLabel.text = detailModel.passtime;
    
    //4.描述文字
    self.descLabel.text = detailModel.text;
    
    //8.评论文字
    if (detailModel.top_comments.count > 0) {
        BDJEssenceComment *comment = [detailModel.top_comments firstObject];
        self.commentLabel.text = comment.content;
    }else {
        self.commentLabel.text = nil;
    }
    
    //强制cell布局一次
    [self layoutIfNeeded];
    
    //8.评论文字布局
    if (detailModel.top_comments.count > 0) {
        self.commentViewYCons.constant = 10;
        self.commentViewHCons.constant = self.commentLabel.frame.size.height+10+5;
    }else {
        //没有评论的部分
        self.commentViewHCons.constant = 0;
        self.commentViewYCons.constant = 0;
    }
    

    //9.标签
    NSMutableString *tagString = [NSMutableString string];
    for (NSInteger i=0;i<detailModel.tags.count;i++){
        BDJEssenceTag *tag = detailModel.tags[i];
        [tagString appendFormat:@"%@ ", tag.name];
    }
    self.tagLabel.text = tagString;
    //10.顶、踩、分享、评论的数量
    [self.dingButton setTitle:detailModel.up forState:UIControlStateNormal];
    [self.caiButton setTitle:detailModel.down.stringValue forState:UIControlStateNormal];
    [self.shareBtn setTitle:detailModel.forward.stringValue forState:UIControlStateNormal];
    [self.dingButton setTitle:detailModel.comment forState:UIControlStateNormal];
    
    //强制刷新一次
    [self layoutIfNeeded];
    //获取cell的高度
    //基本类型转对象 用@()
    detailModel.cellHeight = @(CGRectGetMaxY(self.dingButton.frame)+10+10);
}

+ (EssenceTextCell *)textCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withModel:(BDJEssenceDetail *)detailModel {
    
    static NSString *cellId = @"textCellId";
    EssenceTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EssenceTextCell" owner:nil options:nil] lastObject];
    }
    //数据
    cell.detailModel = detailModel;
    return cell;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
//顶一下
- (IBAction)dingAction:(id)sender {
}

//踩一下
- (IBAction)caiAction:(id)sender {
}

//分享
- (IBAction)shareAction:(id)sender {
}

//评论
- (IBAction)commentAction:(id)sender {
}

//更多按钮点击
- (IBAction)clickMoreBtn:(id)sender {
}

@end
