//
//  BNRItem.h
//  RandomItems
//
//  Created by John Gallagher on 1/12/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCItem : NSObject
@property(nonatomic,copy) NSString * itemName;
@property(nonatomic,copy) NSString * serialNumber;
@property(nonatomic) int valueInDollars;
@property(nonatomic,readonly,strong) NSDate * dateCreated;


+ (instancetype)randomItem;

// Designated initializer for BNRItem
- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;
@end
