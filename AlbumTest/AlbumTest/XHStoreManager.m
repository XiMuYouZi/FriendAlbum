//
//  XHStoreManager.m
//  MessageDisplayExample
//
//  Created by HUAJIE-1 on 14-5-18.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHStoreManager.h"
#import "XHAlbum.h"

@implementation XHStoreManager

+ (instancetype)shareStoreManager {
    static XHStoreManager *storeManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        storeManager = [[XHStoreManager alloc] init];
    });
    return storeManager;
}


- (NSMutableArray *)getAlbumConfigureArray {
    NSMutableArray *albumConfigureArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++) {
        XHAlbum *currnetAlbum = [[XHAlbum alloc] init];
        if (i%2 == 0) {
            currnetAlbum.userName = @"汪畅";
            currnetAlbum.profileAvatarUrlString = @"http://file.zxxk.com/3_22/images/2015-7/ZXXKCOM201507021011472925774.jpg";
            currnetAlbum.albumShareContent = @"朋友圈分享内容，😗😗😗😗😗这里做图片加载，😗😗😗😗😗还是混排好呢？😜😜😜😜😜如果不混排，感觉CoreText派不上场啊！";
            currnetAlbum.albumSharePhotos = [NSArray arrayWithObjects:@"http://file.zxxk.com/3_22/images/2015-7/ZXXKCOM201507021030359250095.jpg", @"http://file.zxxk.com/3_22/images/2015-7/ZXXKCOM201507021011472925774.jpg", nil];
        } else {
            currnetAlbum.userName = @"斐妞";
            currnetAlbum.profileAvatarUrlString = @"http://file.zxxk.com/3_22/images/2015-7/ZXXKCOM201507021030359250095.jpg";
            currnetAlbum.albumShareContent = @"朋友圈分享内容，😗😗😗😗😗这里做图片加载，😗😗😗😗😗还是混排好呢？😜😜😜😜😜如果不混排，感觉CoreText派不上场啊！😄😄😄你说是不是？😗😗😗😗😗如果有混排的需要就更好了！😗😗😗😗😗";
            currnetAlbum.albumSharePhotos = [NSArray arrayWithObjects:
                                             @"http://file.zxxk.com/3_22/images/2015-7/ZXXKCOM201507021445109516066.jpg",
                                             @"http://file.zxxk.com/3_22/images/2015-7/ZXXKCOM201507021443498338240.jpg",
                                             @"http://file.zxxk.com/3_22/images/2015-7/ZXXKCOM201507021201119950808.jpg",
                                             @"http://file.zxxk.com/3_22/images/2015-7/ZXXKCOM201507021202254841969.jpg",
                                             @"http://file.zxxk.com/3_22/images/2015-7/ZXXKCOM201507021159008849069.jpg",
                                             @"http://file.zxxk.com/3_22/images/2015-7/ZXXKCOM201507021200425769025.jpg",
                                             @"http://file.zxxk.com/3_22/images/2015-7/ZXXKCOM201507021201532180202.jpg",
                                             @"http://file.zxxk.com/3_22/images/2015-7/ZXXKCOM201507021203026737702.jpg", nil];
        }
        currnetAlbum.timestamp = [NSDate date];
        currnetAlbum.albumShareLikes = @[@"Jack", @"华仔"];
        currnetAlbum.albumShareComments = @[@"评论啊！", @"再次评论啊！"];
        [albumConfigureArray addObject:currnetAlbum];
    }
    
    return albumConfigureArray;
}

@end
