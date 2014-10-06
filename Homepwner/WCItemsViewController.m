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
#import "WCDetailViewController.h"

@interface WCItemsViewController ()
@property(nonatomic, strong) IBOutlet UIView * headerView;
@end

@implementation WCItemsViewController

-(instancetype) init{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
        for (int i = 0; i < 5; i++) {
            [[WCItemStore sharedStore] createItem];
        }
        UINavigationItem *navigationItem = self.navigationItem;
        navigationItem.title = @"WenwenChu";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        navigationItem.rightBarButtonItem = bbi;
        navigationItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[WCItemStore sharedStore] allItems] count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray * items = [[WCItemStore sharedStore] allItems];
    WCItem * item = items[indexPath.row];
    cell.textLabel.text = [item description];
    
    return cell;
}

-(IBAction)addNewItem:(id)sender
{
    WCItem * newItem = [[WCItemStore sharedStore] createItem];
    NSInteger lastRow = [[[WCItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath * indexPath  = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

-(IBAction)toggleEditingMode:(id)sender
{
    if(self.isEditing)
    {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    }
    
    else
    {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
      {
          NSArray * items = [[WCItemStore sharedStore]allItems];
          WCItem * item = items[indexPath.row];
          [[WCItemStore sharedStore] removeItem:item];
          
          [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[WCItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WCItem * item = [[WCItemStore sharedStore] allItems][indexPath.row];
    WCDetailViewController * dvc = [[WCDetailViewController alloc] init];
    dvc.item = item;
    [self.navigationController pushViewController:dvc animated:YES];
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

@end
