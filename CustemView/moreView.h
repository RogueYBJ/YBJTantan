//
//  moreView.h
//  YiDD
//
//  Created by mac on 2018/9/1.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol moreViewdelegate <NSObject>

//移动的距离
-(void)moreVolue:(CGFloat)volue;
//视图是否被移除
-(void)moreisRemove:(BOOL)isRemove;

@optional

@end

@interface moreView : UIView{
    CGPoint point;//保存点击初始位置
    CGRect rect;//保存视图初始位置
}

//喜欢
@property (nonatomic, weak) UILabel * xh;
//不喜欢
@property (nonatomic, weak) UILabel * bxh;
//协议
@property(weak ,nonatomic)id<moreViewdelegate>delegates;

@end
