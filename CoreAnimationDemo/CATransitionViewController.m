//
//  CATransitionViewController.m
//  CoreAnimationDemo
//
//  Created by dashuios126 on 17/1/9.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

#import "CATransitionViewController.h"

@interface CATransitionViewController ()
@property (weak, nonatomic) IBOutlet UIView *TransitionView;
@property (weak, nonatomic) IBOutlet UIImageView *transitionImageView;

@end

@implementation CATransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.



}
- (IBAction)click:(UIButton *)sender {

    CATransition *animation = [CATransition animation];
    animation.duration = 1.0f;
    /*
     kCATransitionMoveIn  覆盖
     kCATransitionPush  推出
     kCATransitionReveal 揭开
     kCATransitionFade  渐变

     kCATransitionFromLeft     从左边
     kCATransitionFromRight    从右边
     kCATransitionFromBottom   从底部
     kCATransitionFromTop      从顶部
     */
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromTop;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.transitionImageView.layer addAnimation:animation forKey:@"transitionAni"];
    self.transitionImageView.image = [UIImage imageNamed:@"234.jpg"];
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
