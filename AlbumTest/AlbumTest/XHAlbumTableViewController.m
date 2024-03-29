//
//  XHAlbumTableViewController.m
//  MessageDisplayExample
//
//  Created by HUAJIE-1 on 14-5-17.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHAlbumTableViewController.h"

#import "XHFoundationMacro.h"
#import "XHPhotographyHelper.h"
#import "XHPathCover.h"
#import "XHAlbumTableViewCell.h"
#import "XHStoreManager.h"
#import "XHAlbumOperationView.h"
#import "XHSendMessageView.h"

@interface XHAlbumTableViewController () <XHAlbumTableViewCellDelegate, UITextFieldDelegate, XHSendMessageViewDelegate>
@property (nonatomic, strong) XHPathCover *albumHeaderContainerViewPathCover; //视觉差的TableViewHeaderView
@property (nonatomic, strong) XHPhotographyHelper *photographyHelper;
@property (nonatomic, strong) XHAlbumOperationView *operationView;
@property (nonatomic, strong) XHSendMessageView *sendMessageView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end


@implementation XHAlbumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    [self.view addSubview:self.sendMessageView];
    
    self.tableView.tableHeaderView = self.albumHeaderContainerViewPathCover;
    [self configuraTableViewNormalSeparatorInset];
    [self loadDataSource];
}

- (void)dealloc {
    self.albumHeaderContainerViewPathCover = nil;
}

- (XHPathCover *)albumHeaderContainerViewPathCover {
    if (!_albumHeaderContainerViewPathCover) {
        _albumHeaderContainerViewPathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        [_albumHeaderContainerViewPathCover setBackgroundImage:[UIImage imageNamed:@"AlbumHeaderBackgrounImage"]];
        [_albumHeaderContainerViewPathCover setAvatarImage:[UIImage imageNamed:@"book"]];
        [_albumHeaderContainerViewPathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"汪畅", XHUserNameKey, @"1990-10-10", XHBirthdayKey, nil]];
        _albumHeaderContainerViewPathCover.isZoomingEffect = YES;
        
        WEAKSELF
        [_albumHeaderContainerViewPathCover setHandleRefreshEvent:^{
            [weakSelf loadDataSource];
        }];
        
        [_albumHeaderContainerViewPathCover setHandleTapBackgroundImageEvent:^{
            [weakSelf.photographyHelper showOnPickerViewControllerSourceType:UIImagePickerControllerSourceTypePhotoLibrary onViewController:weakSelf compled:^(UIImage *image, NSDictionary *editingInfo) {
                if (image) {
                    [weakSelf.albumHeaderContainerViewPathCover setBackgroundImage:image];
                } else {
                    if (!editingInfo)
                        return ;
                    [weakSelf.albumHeaderContainerViewPathCover setBackgroundImage:[editingInfo valueForKey:UIImagePickerControllerOriginalImage]];
                }
            }];
        }];
    }
    return _albumHeaderContainerViewPathCover;
}

- (XHPhotographyHelper *)photographyHelper {
    if (!_photographyHelper) {
        _photographyHelper = [[XHPhotographyHelper alloc] init];
    }
    return _photographyHelper;
}


//点赞和评论
- (XHAlbumOperationView *)operationView {
    if (!_operationView) {
        _operationView = [XHAlbumOperationView initailzerAlbumOperationView];
        typeof(self) __weak weakSelf = self;
        _operationView.didSelectedOperationCompletion = ^(XHAlbumOperationType operationType) {
            typeof(weakSelf) __strong strongSelf = weakSelf;
            NSLog(@"operationType : %ld", operationType);
            switch (operationType) {
                case XHAlbumOperationTypeLike:
                    [strongSelf addLike]; //点赞
                    break;
                case XHAlbumOperationTypeReply:
                    [strongSelf.sendMessageView becomeFirstResponderForTextField]; //评论
                    break;
                default:
                    break;
            }
        };
    }
    return _operationView;
}
- (XHSendMessageView *)sendMessageView {
    if (!_sendMessageView) {
        _sendMessageView = [[XHSendMessageView alloc] initWithFrame:CGRectZero];
        _sendMessageView.sendMessageDelegate = self;
    }
    return _sendMessageView;
}

#pragma mark - DataSource
- (void)loadDataSource {
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *dataSource = [[XHStoreManager shareStoreManager] getAlbumConfigureArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.albumHeaderContainerViewPathCover stopRefresh];
            weakSelf.dataSource = dataSource;
            [weakSelf.tableView reloadData];
        });
    });
}

#pragma mark - XHSendMessageView Delegate
//点赞
- (void)addLike {
    if (self.selectedIndexPath && self.selectedIndexPath.row < self.dataSource.count) {
        XHAlbum *updateCurrentAlbum = self.dataSource[self.selectedIndexPath.row];
        NSMutableArray *likes = [[NSMutableArray alloc] initWithArray:updateCurrentAlbum.albumShareLikes];
        [likes insertObject:@"仔仔" atIndex:0];
        updateCurrentAlbum.albumShareLikes = likes;
        [self.tableView reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}
//评论
- (void)didSendMessage:(NSString *)message albumInputView:(XHSendMessageView *)sendMessageView {
    if (self.selectedIndexPath && self.selectedIndexPath.row < self.dataSource.count) {
        XHAlbum *updateCurrentAlbum = self.dataSource[self.selectedIndexPath.row];
        NSMutableArray *comments = [[NSMutableArray alloc] initWithArray:updateCurrentAlbum.albumShareComments];
        [comments insertObject:message atIndex:0];
        updateCurrentAlbum.albumShareComments = comments;
        [self.tableView reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        [sendMessageView finishSendMessage];
    }
}

#pragma mark - XHAlbumTableViewCellDelegate
- (void)didShowOperationView:(UIButton *)sender indexPath:(NSIndexPath *)indexPath {
    CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:indexPath];
    CGFloat origin_Y = rectInTableView.origin.y + sender.frame.origin.y;
    CGRect targetRect = CGRectMake(CGRectGetMinX(sender.frame), origin_Y, CGRectGetWidth(sender.bounds), CGRectGetHeight(sender.bounds));
    if (self.operationView.shouldShowed) {
        [self.operationView dismiss];
        return;
    }
    self.selectedIndexPath = indexPath;
    [self.operationView showAtView:self.tableView rect:targetRect];
}

#pragma mark- UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_albumHeaderContainerViewPathCover scrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_albumHeaderContainerViewPathCover scrollViewDidEndDecelerating:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_albumHeaderContainerViewPathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.operationView dismiss];
    [self.sendMessageView resignFirstResponderForInputTextFields];
    self.selectedIndexPath = nil;
    [_albumHeaderContainerViewPathCover scrollViewWillBeginDragging:scrollView];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"albumTableViewCellIdentifier";
    XHAlbumTableViewCell *albumTableViewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!albumTableViewCell) {
        albumTableViewCell = [[XHAlbumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        albumTableViewCell.delegate = self;
    }
    if (indexPath.row < self.dataSource.count) {
        albumTableViewCell.indexPath = indexPath;
        albumTableViewCell.currentAlbum = self.dataSource[indexPath.row];
    }
    return albumTableViewCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [XHAlbumTableViewCell calculateCellHeightWithAlbum:self.dataSource[indexPath.row]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
