//
//  ViewController.m
//  SkypeLikeTabNavigation
//
//  Created by Shwet Solanki on 17/12/14.
//  Copyright (c) 2014 SmartGeek. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, ServiceType) {
    ServiceScheduled,
    ServicePlan,
    ServiceRequested,
    ServiceRecommended,
    ServiceCompleted
};

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    IBOutlet UICollectionView * headerCollectionView;
    IBOutlet UICollectionView * contentCollectionView;
    NSMutableArray * headerColor;
    NSMutableArray * contentColor;
    
    NSIndexPath * currentIndexPath;
    NSIndexPath * possibleIndexPath;

    NSMutableArray * sizeArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [contentCollectionView setContentInset:UIEdgeInsetsMake(50, 0, 0, 0)];
    NSArray * tempArray = @[[UIColor redColor], [UIColor grayColor], [UIColor purpleColor], [UIColor orangeColor], [UIColor yellowColor]];
    headerColor = [NSMutableArray arrayWithArray:tempArray];
    [headerColor addObjectsFromArray:tempArray];
    [headerColor addObjectsFromArray:tempArray];
    
    tempArray = @[[UIColor magentaColor], [UIColor blueColor], [UIColor greenColor], [UIColor cyanColor], [UIColor brownColor]];
    contentColor = [NSMutableArray arrayWithArray:tempArray];
    [contentColor addObjectsFromArray:tempArray];
    [contentColor addObjectsFromArray:tempArray];

    tempArray = @[@(100), @(120), @(160), @(140), @(120)];
    sizeArray = [NSMutableArray arrayWithArray:tempArray];
    [sizeArray addObjectsFromArray:tempArray];
    [sizeArray addObjectsFromArray:tempArray];
    
    currentIndexPath = [NSIndexPath indexPathForRow:[headerColor count] / 3 inSection:0];
    
    NSMutableArray * gestureRecognizers = [headerCollectionView.gestureRecognizers mutableCopy];
    [gestureRecognizers removeObject:headerCollectionView.panGestureRecognizer];
    [gestureRecognizers addObject:contentCollectionView.panGestureRecognizer];
    [headerCollectionView setGestureRecognizers:gestureRecognizers];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [contentCollectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [headerColor count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == contentCollectionView)
    {
        CGSize size = self.view.bounds.size;
        size.height -= 50;
        return size;
    }
    else if(collectionView == headerCollectionView)
    {
        return CGSizeMake([sizeArray[indexPath.row] floatValue], 50);
    }
    
    return CGSizeZero;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = nil;
    UIColor * color = nil;
    if(collectionView == headerCollectionView)
    {
        cellID = @"HeaderCollectionCell";
        color = headerColor[indexPath.row];
    }
    else
    {
        cellID = @"ContentCollectionCell";
        color = contentColor[indexPath.row];
    }
    
    possibleIndexPath = indexPath;
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell setBackgroundColor:color];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == headerCollectionView)
    {
        [contentCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(![possibleIndexPath isEqual:indexPath])
        currentIndexPath = possibleIndexPath;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == contentCollectionView)
    {
        float offsetPercentage = scrollView.contentOffset.x / scrollView.contentSize.width;
        if(!isnan(offsetPercentage) && !isinf(offsetPercentage))
        {
            float singleContentCellPercentage = CGRectGetWidth(scrollView.frame) / scrollView.contentSize.width;
            int completedCellCount = floor(offsetPercentage / singleContentCellPercentage);
            
            float totalWidth = 0.0f;

            float diffPercentage = (offsetPercentage - ((float)completedCellCount * singleContentCellPercentage)) / singleContentCellPercentage;
            
            if(diffPercentage != 0)
            {
                for (int i = 0; i < completedCellCount; i++) {
                    totalWidth += [sizeArray[i] floatValue];
                }
                totalWidth += ([sizeArray[completedCellCount] floatValue] * diffPercentage);
            }
            else
            {
                for (int i = 0; i < completedCellCount; i++) {
                    totalWidth += [sizeArray[i] floatValue];
                }
            }
            
//            NSLog(@"%f | %f | %f | %d",totalWidth, diffPercentage, offsetPercentage, completedCellCount);
            [headerCollectionView setContentOffset:CGPointMake(totalWidth, 0)];
            [self updateCollectionView];
        }
    }
}

-(void)updateCollectionView
{
    __block float contentOffsetWhenFullyScrolledRight = 0;
    contentOffsetWhenFullyScrolledRight = contentCollectionView.frame.size.width * ([headerColor count] - 1);
    float maxContentOffset = (([headerColor count] / 3 * 2)) * CGRectGetWidth(contentCollectionView.frame);
    float minContentOffset = (([headerColor count] / 3) - 1) * CGRectGetWidth(contentCollectionView.frame);
    
    //        NSLog(@"%f | %f | %f",maxContentOffset, minContentOffset, contentCollectionView.contentOffset.x);
    
    if (contentCollectionView.contentOffset.x >= maxContentOffset) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:((([headerColor count] / 3))) inSection:0];
        [contentCollectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    } else if (contentCollectionView.contentOffset.x == minContentOffset)  {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:(([headerColor count] / 3 * 2) - 1) inSection:0];
        [contentCollectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}

@end
