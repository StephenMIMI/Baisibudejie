//
//  BDJEssenceModel.h
//  Baisibudejie
//
//  Created by qianfeng on 16/11/22.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class BDJEssenceInfo;
@class BDJEssenceUser;
@class BDJEssenceVideo;
@class BDJEssenceImage;
@class BDJEssenceAudio;

@protocol BDJEssenceDetail;
@protocol BDJEssenceTag;
@protocol BDJEssenceComment;
@protocol NSString;

@interface BDJEssenceModel : JSONModel

@property (nonatomic, strong)BDJEssenceInfo<Optional> *info;
@property (nonatomic, strong)NSArray<Optional,BDJEssenceDetail> *list;

@end

@interface BDJEssenceInfo : JSONModel

@property (nonatomic, strong)NSNumber<Optional> *count;
@property (nonatomic, strong)NSNumber<Optional> *np;

@end

@interface BDJEssenceDetail : JSONModel

@property (nonatomic, copy)NSString<Optional> *bookmark;
@property (nonatomic, copy)NSString<Optional> *comment;
@property (nonatomic, strong)NSNumber<Optional> *down;

@property (nonatomic, strong)NSNumber<Optional> *forward;
@property (nonatomic, copy)NSString<Optional> *detailId;//id
@property (nonatomic, copy)NSString<Optional> *passtime;

@property (nonatomic, copy)NSString<Optional> *share_url;
@property (nonatomic, strong)NSNumber<Optional> *status;
@property (nonatomic, strong)NSArray<Optional,BDJEssenceTag> *tags;

@property (nonatomic, copy)NSString<Optional> *text;
@property (nonatomic, strong)NSArray<Optional,BDJEssenceComment> *top_comments;
@property (nonatomic, copy)NSString<Optional> *type;

@property (nonatomic, strong)BDJEssenceUser<Optional> *u;
@property (nonatomic, copy)NSString<Optional> *up;
//视频的数据
@property (nonatomic, strong)BDJEssenceVideo<Optional> *video;
//图片的数据
@property (nonatomic, strong)BDJEssenceImage<Optional> *image;
//声音的数据
@property (nonatomic, strong)BDJEssenceAudio<Optional> *audio;

//用来设置和获取对应cell的高度
@property (nonatomic, strong)NSNumber<Optional> *cellHeight;
@end

@interface BDJEssenceAudio : JSONModel
@property (nonatomic, strong)NSNumber<Optional> *duration;
@property (nonatomic, copy)NSArray<Optional, NSString> *download_url;
@property (nonatomic, strong)NSNumber<Optional> *height;
@property (nonatomic, strong)NSNumber<Optional> *width;
@property (nonatomic, strong)NSNumber<Optional> *playcount;
@property (nonatomic, strong)NSNumber<Optional> *playfcount;

@property (nonatomic, copy)NSArray<Optional, NSString> *audio;
@property (nonatomic, copy)NSArray<Optional, NSString> *thumbnail;
@property (nonatomic, copy)NSArray<Optional, NSString> *thumbnail_small;
@end

@interface BDJEssenceImage : JSONModel

@property (nonatomic, strong)NSArray<Optional, NSString> *big;
@property (nonatomic, strong)NSArray<Optional, NSString> *download_url;
@property (nonatomic, strong)NSNumber<Optional> *height;
@property (nonatomic, strong)NSArray<Optional, NSString> *medium;
@property (nonatomic, strong)NSArray<Optional, NSString> *small;
@property (nonatomic, strong)NSArray<Optional, NSString> *thumbnail_small;
@property (nonatomic, strong)NSNumber<Optional> *width;
@end

@interface BDJEssenceTag : JSONModel

@property (nonatomic, strong)NSNumber<Optional> *tagId;//id
@property (nonatomic, copy)NSString<Optional> *name;

@end

@interface BDJEssenceComment : JSONModel

@property (nonatomic, copy)NSString<Optional> *cmt_type;
@property (nonatomic, copy)NSString<Optional> *content;
@property (nonatomic, strong)NSNumber<Optional> *commentId;//id

@property (nonatomic, strong)NSNumber<Optional> *like_count;
@property (nonatomic, copy)NSString<Optional> *passtime;
@property (nonatomic, strong)NSNumber<Optional> *precid;

@property (nonatomic, strong)NSNumber<Optional> *preuid;
@property (nonatomic, strong)NSNumber<Optional> *status;
@property (nonatomic, strong)BDJEssenceUser<Optional> *u;

@property (nonatomic, strong)NSNumber<Optional> *voicetime;
@property (nonatomic, copy)NSString<Optional> *voiceuri;

@end

@interface BDJEssenceUser : JSONModel

@property (nonatomic, strong)NSArray<Optional, NSString> *header;
@property (nonatomic, strong)NSNumber<Optional> *is_vip;
@property (nonatomic, copy)NSString<Optional> *name;

@property (nonatomic, copy)NSString<Optional> *room_icon;
@property (nonatomic, copy)NSString<Optional> *room_name;
@property (nonatomic, copy)NSString<Optional> *room_role;

@property (nonatomic, copy)NSString<Optional> *room_url;
@property (nonatomic, copy)NSString<Optional> *sex;
@property (nonatomic, copy)NSString<Optional> *uid;

@end

@interface BDJEssenceVideo : JSONModel

@property (nonatomic, strong)NSArray<Optional, NSString> *download;
@property (nonatomic, strong)NSNumber<Optional> *duration;
@property (nonatomic, strong)NSNumber<Optional> *height;

@property (nonatomic, strong)NSNumber<Optional> *playcount;
@property (nonatomic, strong)NSNumber<Optional> *playfcount;
@property (nonatomic, strong)NSArray<Optional, NSString> *thumbnail;

@property (nonatomic, strong)NSArray<Optional, NSString> *thumbnail_small;
@property (nonatomic, strong)NSArray<Optional, NSString> *video;
@property (nonatomic, strong)NSNumber<Optional> *width;

@end
