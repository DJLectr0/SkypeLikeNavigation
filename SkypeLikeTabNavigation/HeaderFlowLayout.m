//
//  HeaderFlowLayout.m
//  SkypeLikeTabNavigation
//
//  Created by Shwet Solanki on 18/12/14.
//  Copyright (c) 2014 SmartGeek. All rights reserved.
//

#import "HeaderFlowLayout.h"

@implementation HeaderFlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
//    visibleRect.origin.x += self.collectionView.contentInset.left;
    visibleRect.size = ((UICollectionViewLayoutAttributes *)[array firstObject]).size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        if (CGRectIntersectsRect(attributes.frame, visibleRect)) {
            float difference = CGRectGetMinX(attributes.frame) - CGRectGetMinX(visibleRect);
            float alpha = 0.0;
            
            if(difference < 0)
            {
                //Previous Cell
                difference += CGRectGetWidth(visibleRect);
                alpha = difference / CGRectGetWidth(visibleRect);
            }
            else
            {
                //Next Cell
                difference = CGRectGetWidth(visibleRect) - difference;
                alpha = difference / CGRectGetWidth(visibleRect);
            }
            
            if(alpha >= 0.65)
                attributes.alpha = alpha;
            else
                attributes.alpha = 0.65;
        }
        else
            attributes.alpha = 0.65;
    }
    return array;
}

@end
