//
//  UpdateThumbnailRequest.h
//  AURA
//
//  Created by KindAzrael on 15/7/12.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "NeedLoginRequest.h"

@interface UpdateThumbnailRequest : NeedLoginRequest

- (void)setthumbnail:(NSString *)thumbnail;

@end
