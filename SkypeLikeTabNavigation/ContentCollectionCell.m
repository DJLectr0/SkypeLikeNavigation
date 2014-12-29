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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"Scrolling");
    NSLog(@"View Controller: %@", controller);
    id view = [self superview];
    
    while (view && [view isKindOfClass:[UICollectionView class]] == NO) {
        view = [view superview];
    }
    
    ContentCollectionView *tableView = (ContentCollectionView *)view;
    ViewController *viewController = tableView.controller;
    NSLog(@"View Controller: %@", viewController);
    [viewController setShouldScroll:false];
    NSLog(@"Set shouldScroll to: %i", viewController.shouldScroll);

    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"Stop Scrolling");
    id view = [self superview];
    
    while (view && [view isKindOfClass:[UICollectionView class]] == NO) {
        view = [view superview];
    }
    
    ContentCollectionView *tableView = (ContentCollectionView *)view;
    ViewController *viewController = tableView.controller;
    NSLog(@"View Controller: %@", viewController);
    [viewController setShouldScroll:true];
    NSLog(@"Set shouldScroll to: %i", viewController.shouldScroll);

}

@end
