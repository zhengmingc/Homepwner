//
//  WCItemsViewController.m
//  Homepwner
//
//  Created by Wenwen on 2014-07-23.
//  Copyright (c) 2014 com.wenwenchu. All rights reserved.
//

#import "WCItemsViewController.h"
#import "WCItemStore.h"
#import "WCItem.h"

@implementation WCItemsViewController

-(instancetype) init{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
        for (int i = 0; i < 5; i++) {
            [[WCItemStore sharedStore] createItem];
        }
    }
    return self;
}


-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [[[WCItemStore sharedStore] itemsWithLessThanOrEqualValue:50] count];
            break;
        case 1:
            return [[[WCItemStore sharedStore] itemsWithMoreThanValue:50] count];
            break;
        default:
            return 1;
            break;
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * items;
    WCItem * item;
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
 
    switch (indexPath.section) {
        case 0:
            items = [[WCItemStore sharedStore] itemsWithLessThanOrEqualValue:50];
            item = items[indexPath.row];
            cell.textLabel.text = item.itemName;
            cell.detailTextLabel.text = [item description];
            break;
        case 1:
            items = [[WCItemStore sharedStore] itemsWithLessThanOrEqualValue:50];
            item = items[indexPath.row];
            cell.textLabel.text = item.itemName;
            cell.detailTextLabel.text = [item description];
            break;
        default:
            cell.textLabel.text = @"No more items ...";
            break;
    }
    
    return cell;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Value less than $50";
            break;
        case 1:
            return @"Value more than $50";
            break;
        default:
            return @"";
            break;
    }
}

@end
