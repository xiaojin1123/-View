//
//  SecondViewController.m
//  jumpingView
//
//  Created by 许锦伟 on 2018/9/3.
//  Copyright © 2018年 许锦伟. All rights reserved.
//

#import "SecondViewController.h"

#define COUNT 4.f
#define DURATION 0.55f

@interface SecondViewController () {
    CAReplicatorLayer *replicatorLayer;
    UIBezierPath *bezierPath;
    UIView *jumpingView;
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:254.f/255 green:157.f/255.f blue:154.f/255.f alpha:1];
    jumpingView = [[UIView alloc] initWithFrame:CGRectMake(50, 80, 200, 300)];
    jumpingView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:jumpingView];
    
    replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(jumpingView.frame.origin.x, jumpingView.frame.origin.y, jumpingView.frame.size.width, jumpingView.frame.size.height);
    replicatorLayer.anchorPoint = CGPointMake(0, 0);
    replicatorLayer.backgroundColor= [UIColor clearColor].CGColor;
    [jumpingView.layer addSublayer:replicatorLayer];
    [self firstReplicatorAnimation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)firstReplicatorAnimation {
    CALayer *longLayer = [CALayer layer];
    longLayer.bounds = CGRectMake(0, 0, 30, 130);
    longLayer.anchorPoint = CGPointMake(0, 0);
    longLayer.position = CGPointMake(jumpingView.frame.origin.x + 10, jumpingView.frame.origin.y + 250);
    longLayer.cornerRadius = 2;
    longLayer.backgroundColor = [UIColor whiteColor].CGColor;
    
    CALayer *shortLayer = [CALayer layer];
    shortLayer.bounds = CGRectMake(0, 0, 30, 130);
    shortLayer.anchorPoint = CGPointMake(0, 0);
    shortLayer.position = CGPointMake(jumpingView.frame.origin.x + 60, jumpingView.frame.origin.y + 250 + 25);
    shortLayer.cornerRadius = 2;
    shortLayer.backgroundColor = [UIColor redColor].CGColor;
    
    
    
    [replicatorLayer addSublayer:longLayer];
    replicatorLayer.instanceCount = COUNT;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(40, 0, 0);
    replicatorLayer.instanceDelay = DURATION / COUNT * 4.f;
    
    replicatorLayer.speed = 1.85f;
    replicatorLayer.masksToBounds = YES;
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    moveAnimation.toValue  = @(longLayer.position.y - 80);
    moveAnimation.duration = DURATION;
    moveAnimation.repeatCount = HUGE;
    //设置逆向动画
    moveAnimation.autoreverses = true;
    [longLayer addAnimation:moveAnimation forKey:@""];
    
}

@end
