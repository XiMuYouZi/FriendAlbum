//
//  XHAlbumCollectionViewFlowLayout.m
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-5-21.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHAlbumCollectionViewFlowLayout.h"

#import "XHAlbum.h"

@implementation XHAlbumCollectionViewFlowLayout

- (id)init {
    self = [super init];
    if (self) {
        CGFloat albumPhotoSize = 60;
        if (is_iPhone6Plus) {
            albumPhotoSize = 86;
        } else if (is_iPhone6) {
            albumPhotoSize = 76;
        } else {
            albumPhotoSize = 60;
        }
        self.itemSize = CGSizeMake(albumPhotoSize, albumPhotoSize);
        self.minimumInteritemSpacing = kXHAlbumPhotoInsets;
        self.minimumLineSpacing = kXHAlbumPhotoInsets;
    }
    return self;
}

@end
