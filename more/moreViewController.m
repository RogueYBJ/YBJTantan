//
//  moreViewController.m
//  YiDD
//
//  Created by mac on 2018/8/31.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "moreViewController.h"

#import "moreView.h"

#define baseFrame Frame(38,Height_NavBar + YBJ_ScreenW6(25),300,425)

#define Frame1 Frame(0,0,300,400)

#define Frame2 Frame(3,8,300-6,400)

#define Frame3 Frame(6,16,300-12,400)

#define Frame4 Frame(9,24,300-18,400)


@interface moreViewController ()<moreViewdelegate>
//背景视图
@property (weak , nonatomic)UIView * baseView;
//数据数组
@property (strong ,nonatomic)NSMutableArray * dataArr;
//more数组（视图）
@property (strong ,nonatomic)NSMutableArray * moreArr;
//位置数组（ps:因为位置不能存到数组需要转换，就没有用到）
@property (strong ,nonatomic)NSMutableArray * FrameArr;

@end

@implementation moreViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
        [_dataArr addObject:[UIColor redColor]];
        [_dataArr addObject:[UIColor orangeColor]];
        [_dataArr addObject:[UIColor grayColor]];
        [_dataArr addObject:[UIColor brownColor]];
        [_dataArr addObject:[UIColor greenColor]];
        [_dataArr addObject:[UIColor purpleColor]];
        [_dataArr addObject:[UIColor redColor]];
        [_dataArr addObject:[UIColor orangeColor]];
        [_dataArr addObject:[UIColor grayColor]];
        [_dataArr addObject:[UIColor brownColor]];
        [_dataArr addObject:[UIColor greenColor]];
        [_dataArr addObject:[UIColor purpleColor]];
    }
    return _dataArr;
}

-(NSMutableArray *)moreArr{
    if (!_moreArr) {
        _moreArr = [NSMutableArray new];
    }
    return _moreArr;
}

-(NSMutableArray *)FrameArr{
    if (!_FrameArr) {
        _FrameArr = [NSMutableArray new];
        
    }
    return _FrameArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建父视图
    
    [self setBaseView];
//    [self addChildView];
}

/**
 创建父视图
 */

-(void)setBaseView{
    
    UIView * baseView = [[UIView alloc]initWithFrame:baseFrame];
    [self.view addSubview:baseView];
    baseView.backgroundColor = [UIColor whiteColor];
    _baseView = baseView;
    
    for (int i = 0; i < 5 ; i++) {
        
        [self addChildView:i];
    }
}

/**
 添加子试图
 */

-(void)addChildView:(NSInteger)i{
    
    if (self.dataArr.count == 0) {
        return;
    }
    
    moreView * more = [[moreView alloc]initWithFrame:CGRectMake(0+YBJ_ScreenW6(3*i), 0+8*i, YBJ_ScreenW6(300-(6*i)), YBJ_ScreenW6(400))];
    
    more.backgroundColor = self.dataArr[0];
    
    if (i == 0) {
        more.userInteractionEnabled = YES;
    }
    
    more.tag = i+10;
    
    switch (i) {
        case 0:
            more.frame = Frame1;
            break;
        case 1:
            more.frame = Frame2;
            break;
        case 2:
            more.frame = Frame3;
            break;
        case 3:
            more.frame = Frame4;
            break;
            
        default:
            more.frame = Frame4;
            break;
    }
    
    
    more.delegates = self;
    
    [self.baseView addSubview:more];
    
    [self.baseView sendSubviewToBack:more];
    
    [self.moreArr addObject:more];
    
    [self.dataArr removeObjectAtIndex:0];
    
}
/**
 moredelegates代理
 */
-(void)moreVolue:(CGFloat)volue{
    
    NSLog(@"%f",volue);
    
    for (UIView * tepView in self.moreArr) {
        
        moreView * more = (moreView *)tepView;
        
        CGRect rect = CGRectZero;
        
        switch (more.tag-10) {
            case 0:
                
                break;
            case 1:
                rect = Frame2;
                rect.origin.x -= YBJ_ScreenW6(3*fabs(volue));
                rect.origin.y -= YBJ_ScreenW6(8*fabs(volue));
                rect.size.width += YBJ_ScreenW6(6*fabs(volue));
                more.frame = rect;
                break;
            case 2:
                rect = Frame3;
                rect.origin.x -= YBJ_ScreenW6(3*fabs(volue));
                rect.origin.y -= YBJ_ScreenW6(8*fabs(volue));
                rect.size.width += YBJ_ScreenW6(6*fabs(volue));
                more.frame = rect;
                break;
            case 3:
                rect = Frame4;
                rect.origin.x -= YBJ_ScreenW6(3*fabs(volue));
                rect.origin.y -= YBJ_ScreenW6(8*fabs(volue));
                rect.size.width += YBJ_ScreenW6(6*fabs(volue));
                more.frame = rect;
                break;
                
            default:
                
                break;
        }
        
        
        
    }
    
}

-(void)moreisRemove:(BOOL)isRemove{
    if (isRemove) {
        
        [self.moreArr removeObjectAtIndex:0];
        
        
        if (self.moreArr.count == 0) {
            NSLog(@"没有了！");
        }
        
        for (UIView * tepView in self.moreArr) {
            
            moreView * more = (moreView *)tepView;
        
            more.tag -= 1;
            
            if (more.tag-10 == 0) {
                more.userInteractionEnabled = YES;
            }
            
        }
        [self addChildView:4];
        
    }else{
        for (UIView * tepView in self.moreArr) {
            
            moreView * more = (moreView *)tepView;
            
            switch (more.tag - 10) {
                case 0:
                    
                    break;
                case 1:
                    more.frame = Frame2;
                    break;
                case 2:
                    more.frame = Frame3;
                    break;
                case 3:
                    more.frame = Frame4;
                    break;
                    
                default:
                    break;
            }
        }
    }
}

@end
