//
//  QueryAlbumByUidDataHandler.m
//  AURA
//
//  Created by KindAzrael on 15/7/15.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryAlbumByUidDataHandler.h"
#import "QueryAlbumByUidResponse.h"
#import "Photo.h"
#import "NSDate+Util.h"

@implementation QueryAlbumByUidDataHandler

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [super handleResponse:baseResponse];
  
  QueryAlbumByUidResponse *resp = (QueryAlbumByUidResponse *)baseResponse;
  
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:resp.albums.count];
  for (NSDictionary *dict in resp.albums) {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    if ([[dict objectForKey:@"coverinfo"] isKindOfClass:[NSDictionary class]]) {
      [data addEntriesFromDictionary:[dict objectForKey:@"coverinfo"]];
      [data setObject:dict forKey:@"albuminfo"];
      [data setValue:[dict objectForKey:@"creatorinfo"] forKey:@"creatorinfo"];
      [array addObject:[[Photo alloc] initWithData:data]];
    }
  }
  
  [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    Photo *photo1 = obj1;
    Photo *photo2 = obj2;
    NSDate *date1 = [NSDate dateFromYYYYMMDDHHMMSS: photo1.ctime];
    NSDate *date2 = [NSDate dateFromYYYYMMDDHHMMSS: photo2.ctime];
    
    return [date2 compare:date1];
  }];
  
  [DataManager userInfo].myAlbum = array;
}

@end
