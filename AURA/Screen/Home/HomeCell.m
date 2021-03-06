//
//  HomeCellTableViewCell.m
//  AURA
//
//  Created by MacMiniS on 14-10-29.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "HomeCell.h"
#import "ViewControllerContainer.h"
#import "UIImageView+Util.h"
#import "APIManager.h"
#import "MainToolbar.h"
#import "NSString+Util.h"
#import "NSDate+Util.h"
#import "DataManager.h"
#import "UIView+Util.h"
#import "MainToolbar.h"
#import "SVProgressHUD.h"

@interface HomeCell ()

@property (nonatomic, strong) Photo *photo;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation HomeCell

- (void)initWithPhoto:(Photo *)photo andIndexPath:(NSIndexPath *)indexPath andType:(NSInteger)type{
  self.photo = photo;
  self.indexPath = indexPath;
  self.type = type;
  [self.imgPhoto setImageeWithSha1:[photo sha1] withPlaceHolder:nil];
  self.lblAlbumName.text = [[photo albuminfo] name];
  self.imageArrow.image = [UIImage imageNamed:[self getArrow:[[photo albuminfo] type]]];
  self.lblLikeCount.text = [photo fcount];
  self.lblDescription.text = [NSString stringWithFormat:@"%@ %@", photo.creatorinfo.nickname, [NSDate getTimeStringFrom:photo.ctime]];
  [self.imgUser setUserImageWithSha1:photo.creatorinfo.thumbnail];
  [self.imgUser setCornerRadius:20];
  [self.imgUser setBorder:1 andColor:[[UIColor whiteColor] CGColor]];
  
  if (photo.haveFavourte) {
    [self.btnLike setImage:[UIImage imageNamed:@"05相册外_赞点击态"] forState:UIControlStateNormal];
  } else {
    [self.btnLike setImage:[UIImage imageNamed:@"05相册外_赞"] forState:UIControlStateNormal];
  }
}

- (IBAction)onClickUser:(id)sender {
    [ViewControllerContainer showUserCenter:self.photo.creatorinfo.userid];
}

- (IBAction)onClickLike:(id)sender {
  if (!self.photo.haveFavourte) {
    FavouriteRequest *request = [[FavouriteRequest alloc] init];
    [request setPhotoid:self.photo.photoid];
    [APIManager favourite:request success:^{
      self.lblLikeCount.text = [self.photo.fcount add:1];
      [self.btnLike setImage:[UIImage imageNamed:@"05相册外_赞点击态"] forState:UIControlStateNormal];
      self.photo.haveFavourte = YES;
    } failure:^{}];
  }
}

- (IBAction)onClickComment:(id)sender {
  [ViewControllerContainer showPhotoDetail:self.photo];
}

- (IBAction)onClickMore:(id)sender {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    [MainToolbar showMainToolbar];
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    [SVProgressHUD showSuccessWithStatus:@"你的举报我们已经收到"];
    [MainToolbar showMainToolbar];
  }]];
  
  if ([self.photo.creatorinfo.userid isMe]) {
    [alertController addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
      [MainToolbar showMainToolbar];
      DeletePhotoRequest *request = [[DeletePhotoRequest alloc] init];
      [request setPhotoid:self.photo.photoid];
      [APIManager deletePhoto:request success:^{
        if (self.type == ACTIVITY_TYPE) {
          [[DataManager activityArray] removeObjectAtIndex:self.indexPath.row];
        } else if (self.type == DISCOVERY_TYPE) {
          [[DataManager discoveryArray] removeObjectAtIndex:self.indexPath.row];
        } else if (self.type == SEARCH_TYPE){
          [[DataManager searchAlbumArray] removeObjectAtIndex:self.indexPath.row];
        } else if (self.type == MYALBUM_TYPE) {
          [[DataManager userInfo].myAlbum removeObjectAtIndex:self.indexPath.row - 1];
        }
        
        [self.supperController.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
      } failure:^{}];
    }]];
  }
  
  
  [self.supperController presentViewController:alertController animated:YES completion:nil];
  [MainToolbar hideMainToolbar];
}

- (IBAction)onClickDetail:(id)sender {
  [ViewControllerContainer showAlbumDetail:self.photo.albuminfo];
}

- (NSString *)getArrow:(NSString *)type {
  if ([type isEqualToString:PRIVATE]) {
    return @"05相册外_箭头_green";
  } else if ([type isEqualToString:SPORTS]) {
    return @"05相册外_箭头";
  }  else if ([type isEqualToString:TOURISM]) {
    return @"05相册外_箭头_yellow";
  }  else if ([type isEqualToString:PARTY]) {
    return @"05相册外_箭头_blue";
  }  else if ([type isEqualToString:SHOW]) {
    return @"05相册外_箭头_purole";
  }
  
  return nil;
}

@end
