//
//  TagLabel.h
//  AURA
//
//  Created by KindAzrael on 14/11/18.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagLabel : UILabel

+ (instancetype)tagLabelWithTagString:(NSString *)tag;
+ (CGFloat)calcTagLength:(NSString *)tagText;

- (void)setColor:(UIColor *)color;

@end
