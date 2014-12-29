//
//  ContentCollectionCell.m
//  SkypeLikeTabNavigation
//
//  Created by Shwet Solanki on 29/12/14.
//  Copyright (c) 2014 SmartGeek. All rights reserved.
//

#import "ContentCollectionCell.h"

@implementation ContentCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - UITableView Datasource methods -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    [cell.textLabel setText:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
    return cell;
}

@end
