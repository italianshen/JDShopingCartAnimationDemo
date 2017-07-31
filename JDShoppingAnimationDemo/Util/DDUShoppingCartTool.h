//
//  DDUShoppingCartTool.h
//  JDShoppingAnimationDemo
//
//  Created by Danny on 2017/7/31.
//  Copyright © 2017年 Danny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DDUShoppingCartTool : NSObject

/**
 *  添加商品到购物车
 *
 *  @param goodsImage 商品图片
 *  @param startPoint 动画起始点
 *  @param endPoint   动画结束点
 *  @param completion 完成回调
 */
+(void)addToShopingCartWithGoodsImage:(UIImage *)goodsImage
                           startPoint:(CGPoint) startPoint
                             endPoint:(CGPoint)endPoint
                           completion:(void (^)(BOOL finished))completion;


@end
