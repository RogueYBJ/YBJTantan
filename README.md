# YBJTantan
Tantan Home slide effect


###
![ 效果图 ](https://github.com/RogueYBJ/YBJTantan/raw/master/tantan.gif)

###
moreView.h（moreViewdelegate）
```
@protocol moreViewdelegate <NSObject>

//移动的距离
-(void)moreVolue:(CGFloat)volue;
//视图是否被移除
-(void)moreisRemove:(BOOL)isRemove;

@optional

```

###
moreView.h（成员变量）

```
CGPoint point;//保存点击初始位置
CGRect rect;//保存视图初始位置
```

###
moreViewController.m（属性）

```
#import "moreViewController.h"

#import "moreView.h"

//设置需要的位置（可自行设置）

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

```

