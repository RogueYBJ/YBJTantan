//
//  moreView.m
//  YiDD
//
//  Created by mac on 2018/9/1.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "moreView.h"

@implementation moreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
        
        //布局UI
        [self LayoutUI];
        
        
        //添加拖动按钮
        self.userInteractionEnabled = NO;
        
        [self addPanAction:@selector(panAction:)];
    }
    return self;
}

-(void)LayoutUI{
    
    UILabel * xh = [[UILabel alloc]init];
    xh.text = @"喜欢";
    [xh sizeToFit];
    [self addSubview:xh];
    _xh = xh;
    _xh.alpha = 0;
    
    UILabel * bxh = [[UILabel alloc]init];
    bxh.text = @"不喜欢";
    [bxh sizeToFit];
    [self addSubview:bxh];
    _bxh = bxh;
    _bxh.alpha = 0;
}

-(void)panAction:(UIPanGestureRecognizer *)pan{
    UIView * view = (UIView *)pan.view;
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        //存储准备开始滑动的坐标
        
        point = [pan locationInView: [view superview] ];
        
        rect = view.frame;
        
        
    }else if (pan.state == UIGestureRecognizerStateChanged){
        //监听滑动的距离并改变view的位置
        
        CGRect rects = rect;
        
        CGFloat x = [pan locationInView:[view superview]].x - point.x;
        
        CGFloat y = [pan locationInView:[view superview]].y - point.y;
        
        rects.origin = CGPointMake(rect.origin.x + x, rect.origin.y + y);
        
        view.frame = rects;
        
        //判断是否划出制定区域
        
        if (view.center.x > YBJ_ScreenW || view.center.x < 0 || view.center.y > YBJ_ScreenH || view.center.y < 0){
            if (view.center.x > YBJ_ScreenW) {
                self.xh.alpha = 1;
            }
            if (view.center.x < 0) {
                self.bxh.alpha = 1;
            }
            return;
        }
        
        //监听滑动的比例控制动画以及喜欢
        
        CGFloat xx = (view.center.x-(view.width/2))/(view.width/2);
        
        if (xx<0) {
            self.bxh.alpha = fabs(xx);
        }else{
            self.xh.alpha = fabs(xx);
        }
        
        [self viewAnimationfloat:(xx * 0.05)];
        
        [self.delegates moreVolue:xx];
        
        
    }else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateFailed){
        
        
        //判断是松手时是否划出制定区域
        if (view.center.x > YBJ_ScreenW || view.center.x < 0 || view.center.y > YBJ_ScreenH || view.center.y < 0) {
            [self removeFromSuperview];
            [self.delegates moreisRemove:YES];
        }else{
            
            [self.delegates moreisRemove:NO];
            [UIView animateWithDuration:0.2 animations:^{
                self.xh.alpha = 0;
                self.bxh.alpha = 0;
                view.frame = self->rect;
                [self viewAnimationfloat:0];
            }];
        }
    }
}

//CABasicAnimation动画
-(void)viewAnimationfloat:(CGFloat)f{
    
    //根据z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat: M_PI * f];
    animation.duration = 0.2f;
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = 0;
    [self.layer addAnimation:animation forKey:nil];
    
}

@end
