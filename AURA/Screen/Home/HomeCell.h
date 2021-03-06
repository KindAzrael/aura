//
//  HomeCellTableViewCell.h
//  AURA
//
//  Created by MacMiniS on 14-10-29.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

#define ACTIVITY_TYPE 0
#define DISCOVERY_TYPE 1
#define SEARCH_TYPE 2
#define MYALBUM_TYPE 3

@interface HomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *lblAlbumName;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblLikeCount;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UIButton *btnDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageArrow;

@property (weak, nonatomic) UITableViewController *supperController;
@property (nonatomic, assign) NSInteger type;

- (void)initWithPhoto:(Photo *)photo andIndexPath:(NSIndexPath *)indexPath andType:(NSInteger)type;

@end
