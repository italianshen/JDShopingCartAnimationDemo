//
//  DDUShoppingCartTool.m
//  JDShoppingAnimationDemo
//
//  Created by Danny on 2017/7/31.
//  Copyright © 2017年 Danny. All rights reserved.
//

#import "DDUShoppingCartTool.h"

@implementation DDUShoppingCartTool

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
                           completion:(void (^)(BOOL finished))completion{
    
  //创建动画的图层
    CAShapeLayer *shapelayer =[[CAShapeLayer alloc]init];
    shapelayer.frame = CGRectMake(startPoint.x - 20, startPoint.y - 20, 40, 40);
    //包裹图片的图层 也就是动画的图层
    shapelayer.contents = (id)goodsImage.CGImage;
    
    //获取window的顶层控制器
    UIViewController *rootVC =[[UIApplication sharedApplication].delegate window].rootViewController;
    UIViewController *parentVC = rootVC;
    
    while ((parentVC = rootVC.presentedViewController) != nil) {
        rootVC = parentVC;
    }
    
    while ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = [(UINavigationController *)rootVC topViewController];
    }
    //添加layer到顶层视图控制器上
    [rootVC.view.layer addSublayer:shapelayer];
    
    //创建运动轨迹
    UIBezierPath *movePath =[UIBezierPath bezierPath];
    [movePath moveToPoint:startPoint];
    //指定动画结束点 和 动画的锚点
    [movePath addQuadCurveToPoint:endPoint controlPoint:CGPointMake(200, 100)];
    
    //轨迹动画
    CAKeyframeAnimation *pathAnimation =[CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGFloat durationTime = 1;//动画时长
    pathAnimation.duration = durationTime;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.path = movePath.CGPath;
    
    //创建缩小的scale动画
    CABasicAnimation *scaleAnimation =[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue =[NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue =[NSNumber numberWithFloat:0.5];
    scaleAnimation.duration = 1.0;
    scaleAnimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    //添加轨迹动画
    [shapelayer addAnimation:pathAnimation forKey:nil];
    [shapelayer addAnimation:scaleAnimation forKey:nil];
    
    
    //动画结束后执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [shapelayer removeFromSuperlayer];
        completion(YES);
    });

}


@end
