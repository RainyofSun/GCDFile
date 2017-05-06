//
//  RCountdownView.m
//  GCD
//
//  Created by 刘冉 on 2017/5/2.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "RCountdownView.h"

static NSInteger countDownNum;//倒计时时间
@interface RCountdownView ()

@property(nonatomic,strong)CAShapeLayer* myShapeLayer;
@property(nonatomic,strong)UILabel* numLabel;
//GCD定时器
@property(nonatomic,strong)dispatch_source_t times;
//标示--->定时器是否开启
@property(nonatomic,assign)BOOL isStart;

@end

@implementation RCountdownView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(numChange:)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        self.isStart = NO;
        countDownNum = 4;
        [self layerAnimation];
        [self addSubview:self.numLabel];
    }
    return self;
}

#pragma mark - label的点击方法
-(void)numChange:(UIGestureRecognizer*)sender{
    if (!self.isStart) {
        [self countDown:countDownNum];
    } else {
        dispatch_cancel(self.times);
        self.numLabel.text = [NSString stringWithFormat:@"%ld",countDownNum];
        self.myShapeLayer.strokeEnd = 1.0f;
        [self countDown:countDownNum];
    }
    
}

#pragma mark - GCD倒计时
-(void)countDown:(NSInteger)timer{
    __block NSInteger count;
    count = timer;
    dispatch_queue_t queue = dispatch_get_main_queue();
    self.times = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0*NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(timer* NSEC_PER_SEC);
    dispatch_source_set_timer(self.times, start, interval, 0);
    //设置回调
    dispatch_source_set_event_handler(self.times, ^{
        if (count == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                countDownNum = 4;
                self.numLabel.text = @"4";
                self.myShapeLayer.strokeEnd = 1.0;
            });
            //取消定时器
            dispatch_cancel(self.times);
            self.times = nil;
            self.isStart = NO;
        } else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.numLabel.text = [NSString stringWithFormat:@"%ld",count];
                if (self.myShapeLayer.strokeEnd == 1 || self.myShapeLayer.strokeEnd != 0) {
                    self.myShapeLayer.strokeEnd -= 0.25;
                } else if (self.myShapeLayer.strokeStart == self.myShapeLayer.strokeEnd){
                    self.myShapeLayer.strokeEnd = 1;
                }
//                CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//                pathAnimation.duration =1.0;
//                pathAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
//                pathAnimation.toValue =[NSNumber numberWithFloat:0.3f];
//                //使视图保留到最新状态
//                pathAnimation.removedOnCompletion =NO;
//                pathAnimation.fillMode =kCAFillModeForwards;
//                [self.myShapeLayer addAnimation:pathAnimation forKey:nil];
            });
        }
        count --;
    });
    //开启定时器
    dispatch_resume(self.times);
    self.isStart = YES;
}

-(void)layerAnimation{
    //贝塞尔画圆
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30, 30) radius:30 startAngle:0 endAngle:M_PI *2 clockwise:NO];
    //初始化shapeLayer
    self.myShapeLayer = [CAShapeLayer layer];
    _myShapeLayer.frame = self.bounds;
    _myShapeLayer.strokeColor = [UIColor greenColor].CGColor;//边沿线色
    _myShapeLayer.fillColor = [UIColor clearColor].CGColor;//填充色
    _myShapeLayer.lineJoin = kCALineJoinMiter;//线拐点的类型
    _myShapeLayer.lineCap = kCALineCapSquare;//线终点
    //从贝塞尔曲线获得形状
    _myShapeLayer.path = path.CGPath;
    //线条宽度
    _myShapeLayer.lineWidth = 3;
    //起始和终止
    _myShapeLayer.strokeStart = 0.0;
    _myShapeLayer.strokeEnd = 1.0;
    //将layer添加进图层
    [self.layer addSublayer:_myShapeLayer];
}

-(UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.frame = CGRectMake(CGRectGetMidX(self.bounds)-20, CGRectGetMidY(self.bounds)-20, 40, 40);
        _numLabel.backgroundColor = [UIColor yellowColor];
        _numLabel.text = @"4";
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.userInteractionEnabled = YES;
    }
    return _numLabel;
}

@end
