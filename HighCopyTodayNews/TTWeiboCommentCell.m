//
//  TTWeiboCommentCell.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/17.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "TTWeiboCommentCell.h"
#import "WeiboCommentModel.h"
#import "UIImageView+WebCache.h"
#import "NSDate+YYAdd.h"
@implementation TTWeiboCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setDataModel:(WeiboCommentModel*)model{
    [self.txImg sd_setImageWithURL:[NSURL URLWithString:model.comment.user_profile_image_url]];
    [self.nameShow setTitle:model.comment.user_name forState:0];
    self.zangCountLable.text=[NSString stringWithFormat:@"%ld",model.comment.digg_count];
    self.contentLable.text=model.comment.text;
    long long time=model.comment.create_time;
    NSDate *timedate=[NSDate dateFromTimeInterval:time];
    NSString *timeStr=[NSDate detailTimeAgoString:timedate];
    self.timeShowLable.text=[NSString stringWithFormat:@"%@ . 回复",timeStr];
}
@end
