//
//  WCItemStore.h
//  Homepwner
//
//  Created by Wenwen on 2014-07-23.
//  Copyright (c) 2014 com.wenwenchu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCItem;
@interface WCItemStore : NSObject
@property(nonatomic, readonly) NSArray * allItems;

+(instancetype) sharedStore;
-(WCItem *) createItem;
-(NSArray *) itemsWithMoreThanValue : (int) value;
-(NSArray *) itemsWithLessThanOrEqualValue : (int) value;

@end
