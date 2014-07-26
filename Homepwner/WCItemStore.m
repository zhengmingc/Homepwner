//
//  WCItemStore.m
//  Homepwner
//
//  Created by Wenwen on 2014-07-23.
//  Copyright (c) 2014 com.wenwenchu. All rights reserved.
//

#import "WCItemStore.h"
#import "WCItem.h"

@interface WCItemStore()

@property(nonatomic) NSMutableArray * privateItems;

@end

@implementation WCItemStore


+(instancetype) sharedStore
{
    static WCItemStore * shareStore = nil;
    if(!shareStore){
        shareStore = [[WCItemStore alloc] initPrivate];
    }
    
    return shareStore;
}

-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use WCItemStore"
                                 userInfo:nil];
}

-(instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc]init];
    }
    return self;
}

-(NSArray *) allItems
{
    return  [self.privateItems copy];
}

-(WCItem *)createItem
{
    WCItem * newItem = [WCItem randomItem];
    
    [self.privateItems addObject:newItem];
    NSLog(@"Newly generated item is %@",newItem);
    return newItem;
}

-(NSArray *) itemsWithMoreThanValue : (int) value
{
    NSPredicate * valuePredicate = [NSPredicate predicateWithFormat:@"valueInDollars > %d",value];
    NSArray * newArray =[self.privateItems filteredArrayUsingPredicate:valuePredicate];
    return newArray;
}


-(NSArray *) itemsWithLessThanOrEqualValue : (int) value
{
    NSPredicate * valuePredicate = [NSPredicate predicateWithFormat:@"valueInDollars <= %d",value];
    NSArray * newArray =[self.privateItems filteredArrayUsingPredicate:valuePredicate];
    return newArray;
}
@end
