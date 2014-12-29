//
//  ContentCollectionView.m
//  SkypeLikeTabNavigation
//
//  Created by Leonardo Galli on 29.12.14.
//  Copyright (c) 2014 SmartGeek. All rights reserved.
//

#import "ContentCollectionView.h"

@implementation ContentCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(ContentCollectionView*)initWithController:(ViewController*) aController andFrame:(CGRect)aFrame
{
    if (self = [super initWithFrame:aFrame])
    {
        _controller = aController;
        NSLog(@"Hi there");
        // more initialisation here
    }
    
    return self;
}

@end
