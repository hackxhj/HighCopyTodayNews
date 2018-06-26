//
//  CategoryCollectionViewFlowLayout.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/2.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "CategoryCollectionViewFlowLayout.h"

@implementation CategoryCollectionViewFlowLayout


- (UICollectionViewLayoutAttributes*)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    
    attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), M_PI);
    attr.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds));
    
    return attr;
}

@end
