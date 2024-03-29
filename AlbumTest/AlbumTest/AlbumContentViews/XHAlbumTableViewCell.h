//
//  XHAlbumTableViewCell.h
//  MessageDisplayExample
//
//  Created by HUAJIE-1 on 14-5-19.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHAlbum.h"


@protocol XHAlbumTableViewCellDelegate <NSObject>
@optional
- (void)didShowOperationView:(UIButton *)sender indexPath:(NSIndexPath *)indexPath;
@end


@interface XHAlbumTableViewCell : UITableViewCell

@property (nonatomic, weak) id <XHAlbumTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) XHAlbum *currentAlbum;

+ (CGFloat)calculateCellHeightWithAlbum:(XHAlbum *)currentAlbum;

@end
