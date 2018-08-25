//
//  ViewController.m
//  jumpingView
//
//  Created by 许锦伟 on 2018/8/22.
//  Copyright © 2018年 许锦伟. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CAShapeLayer *jumpingLayer;
@property (nonatomic, strong) CAShapeLayer *jumpingLayer1;
@property (nonatomic, strong) CAShapeLayer *jumpingLayer2;
@property (nonatomic, strong) CAShapeLayer *jumpingLayer3;
@property (nonatomic, strong) UIView *jumpingView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillLayoutSubviews {
    self.jumpingView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 70, 80)];
    self.jumpingView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.jumpingView];
    CGPoint point1 = CGPointMake(60, 5.f);
    CGPoint point2 = CGPointMake(45, 5.f);
    CGPoint point3 = CGPointMake(30, 5.f);
    CGPoint point4 = CGPointMake(15, 5.f);
    
    CGFloat lineLength = 70.f - 2*5.f;
    self.jumpingLayer = [self createLineLayer:point1 toPoint:CGPointMake(point1.x , point1.y + lineLength) withColor: [UIColor whiteColor]];
    self.jumpingLayer1 = [self createLineLayer:point2 toPoint:CGPointMake(point2.x ,point2.y + lineLength) withColor: [UIColor whiteColor]];
    self.jumpingLayer2 = [self createLineLayer:point3 toPoint:CGPointMake(point3.x , point3.y + lineLength) withColor: [UIColor whiteColor]];
    self.jumpingLayer3 = [self createLineLayer:point4 toPoint:CGPointMake(point4.x ,point4.y + lineLength) withColor: [UIColor whiteColor]];
    CGSize tempSize = self.jumpingLayer1.bounds.size;
    tempSize = CGSizeMake(tempSize.width, tempSize.height / 2);
    [self.jumpingView.layer addSublayer:self.jumpingLayer];
    [self.jumpingView.layer addSublayer:self.jumpingLayer1];
    [self.jumpingView.layer addSublayer:self.jumpingLayer2];
    [self.jumpingView.layer addSublayer:self.jumpingLayer3];
    [self createLineLayerAnim:self.jumpingLayer1 keyPath:@"strokeEnd"];
    [self createLineLayerAnim:self.jumpingLayer3 keyPath:@"strokeEnd"];
    self.jumpingView.transform = CGAffineTransformMakeRotation(-M_PI);
}

- (IBAction)beginBtnClick:(id)sender {
    [self createLineLayerAnim:self.jumpingLayer keyPath:@"strokeEnd" pointX:0.f pointY:15.f values:@[@1,@0.35,@1]];
    [self createLineLayerAnim:self.jumpingLayer1 keyPath:@"strokeEnd" pointX:0.f pointY:15.f values:@[@0.35,@01,@0.35]];
    [self createLineLayerAnim:self.jumpingLayer2 keyPath:@"strokeEnd" pointX:0.f pointY:35.f values:@[@1,@0.35,@1]];
    [self createLineLayerAnim:self.jumpingLayer3 keyPath:@"strokeEnd" pointX:0.f pointY:55.f values:@[@0.35,@01,@0.35]];
}
- (IBAction)stopBtnClick:(id)sender {
    [self.jumpingLayer removeAnimationForKey:@"jumping"];
    [self.jumpingLayer1 removeAnimationForKey:@"jumping"];
    [self.jumpingLayer2 removeAnimationForKey:@"jumping"];
    [self.jumpingLayer3 removeAnimationForKey:@"jumping"];
}
- (CAShapeLayer *)createLineLayer:(CGPoint)fromPoint toPoint:(CGPoint)toPoint withColor:(UIColor *)color {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:fromPoint];
    [path addLineToPoint:toPoint];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineCap = kCALineCapRound;
    layer.strokeColor = color.CGColor;
    layer.lineWidth = 3.f;
    layer.path = path.CGPath;
    return layer;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)createLineLayerAnim:(CAShapeLayer *)layer keyPath:(NSString *)keyPath {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:keyPath];
    anim.fillMode = kCAFillModeForwards;
    anim.fromValue = @1;
    anim.toValue = @0.35;
    anim.duration = 0;
    anim.removedOnCompletion = NO;
    [layer addAnimation:anim forKey:keyPath];
    
}

- (void)createLineLayerAnim:(CAShapeLayer *)layer keyPath:(NSString *)keyPath pointX:(CGFloat)pointx pointY:(CGFloat)pointy values:(NSArray *)values{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    //设置动画不停止
    anim.repeatCount = HUGE_VALF;
    anim.duration = 0.45f;
    anim.values = values;
    [layer addAnimation:anim forKey:@"jumping"];
}
@end
