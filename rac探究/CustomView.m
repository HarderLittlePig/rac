//
//  CustomView.m
//  rac探究
//
//  Created by jinjun on 2018/6/12.
//  Copyright © 2018年 jinjun. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

//hitTest:withEvent:是UIView的一个方法，该方法会被系统调用，是用于在视图(UIView)层次结构中找到一个最合适的UIView来响应触摸事件。
//一个触摸事件事件传递顺序大致如下：
//touch->UIApplication->UIWindow->UIViewController.view->subViews->...->view
//其含义为:当用户点击屏幕时，会产生一个触摸事件，系统会将该事件加入到由UIApplication管理的事件队列中,UIApplication会从事件队列中取出最早的事件进行分发处理，先发送事件给应用程序的主窗口UIWindow,主窗口会调用其hitTest:withEvent:方法在视图(UIView)层次结构中找到一个最合适的UIView来处理触摸事件
/*
 执行顺序如下：
 
 1首先在当前视图的hitTest方法中调用pointInside方法判断触摸点是否在当前视图内
 2若pointInside方法返回NO，说明触摸点不在当前视图内，则当前视图的hitTest返回nil，该视图不处理该事件
 3若pointInside方法返回YES，说明触摸点在当前视图内，则从最上层的子视图开始（即从subviews数组的末尾向前遍历），遍历当前视图的所有子视图，调用子视图的hitTest方法重复步骤1-3
 4直到有子视图的hitTest方法返回非空对象或者全部子视图遍历完毕
 5若第一次有子视图的hitTest方法返回非空对象，则当前视图的hitTest方法就返回此对象，处理结束
 6若所有子视图的hitTest方法都返回nil，则当前视图的hitTest方法返回当前视图本身，最终由该对象处理触摸事件
 
 */

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    //系统默认会忽略isUserInteractionEnabled设置为NO、隐藏、alpha小于等于0.01的视图
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    if ([self pointInside:point withEvent:event]) {
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            CGPoint convertedPoint = [subview convertPoint:point fromView:self];
            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
            if (hitTestView) {
                return hitTestView;
            }
        }
        return self;
    }
    return nil;
}

@end
