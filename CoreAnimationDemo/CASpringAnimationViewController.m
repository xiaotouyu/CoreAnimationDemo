//
//  CASpringAnimationViewController.m
//  CoreAnimationDemo
//
//  Created by dashuios126 on 17/1/9.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

#import "CASpringAnimationViewController.h"

@interface CASpringAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *CASpringAnimationView;

@end

@implementation CASpringAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)click:(UIButton *)sender {
/*
 　　CASpringAnimation是iOS9新加入动画类型，是CABasicAnimation的子类，用于实现弹簧动画。
    
 重要属性：
 1. mass: 质量,影响图层运动时的弹簧惯性，质量越大，弹簧的拉伸和压缩的幅度越大
 2. stiffness: 刚度系数，刚度系数越大，形变产生的力就越大，运动越快
 3. damping: 阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
 4. initialVelocity: 初始速率，动画视图的初始速度大小，速度为正数时速度方向与运动方向一致，速度为负数时速度方向与运动方向相反。
 5.settlingDuration: 结算时间（根据动画参数估算弹簧开始运动到停止的时间，动画设置的时间最好根据此时间来设置）

 */
    CASpringAnimation *animation = [CASpringAnimation animation];
    animation.keyPath = @"bounds";
    animation.mass = 10.0;
    animation.stiffness = 500000;
    animation.damping = 10;
    animation.initialVelocity = 5.0;
    animation.duration = animation.settlingDuration;
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(100, 100, 300, 300)];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.CASpringAnimationView.layer addAnimation:animation forKey:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
