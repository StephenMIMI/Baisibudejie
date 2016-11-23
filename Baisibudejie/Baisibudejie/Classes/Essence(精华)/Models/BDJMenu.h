//
//  BDJMenu.h
//  Baisibudejie
//
//  Created by qianfeng on 16/11/23.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class BDJDefault;
@protocol BDJMenuDetail;
@protocol BDJSubmenu;

@interface BDJMenu : JSONModel

@property (nonatomic, strong)BDJDefault<Optional> *default_menu;
@property (nonatomic, strong)NSArray<Optional, BDJMenuDetail> *menus;

@end

@interface BDJDefault : JSONModel

@property (nonatomic, copy)NSString *initial;
@property (nonatomic, copy)NSString *offline_day_3;
@property (nonatomic, copy)NSString *offline_day_7;

@end

@interface BDJMenuDetail : JSONModel

@property (nonatomic, copy)NSString *name;
@property (nonatomic, strong)NSArray<Optional, BDJSubmenu> *submenus;

@end

@interface BDJSubmenu : JSONModel

@property (nonatomic, copy)NSString *entrytype;
@property (nonatomic, copy)NSString *god_topic_type;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *recsys_url;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *url;

@end