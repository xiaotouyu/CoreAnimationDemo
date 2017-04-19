//
//  CAAnimationGroupViewController.m
//  CoreAnimationDemo
//
//  Created by dashuios126 on 17/1/9.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

#import "CAAnimationGroupViewController.h"

@interface CAAnimationGroupViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIButton *groupView1;
@property (weak, nonatomic) IBOutlet UIButton *groupView2;
@property (weak, nonatomic) IBOutlet UIButton *groupView3;

@end

@implementation CAAnimationGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)click:(UIButton *)sender {

   // 使用Group可以将多个动画合并一起加入到层中，Group中所有动画并发执行，可以方便地实现需要多种类型动画的场景。

    CABasicAnimation *animation01 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation01.toValue = [NSValue valueWithCGPoint:self.groupView1.center];

    CABasicAnimation *animation02 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation02.fromValue = @(1.0);
    animation02.toValue = @(0.7);

    CABasicAnimation *animation03 = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation03.toValue = [NSValue valueWithCGRect:self.groupView1.bounds ];



    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation01,animation02,animation03];
    group.duration = 1.0;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.delegate = self;
    [self.groupView2.layer addAnimation:group forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    if (flag) {
        

    }
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
