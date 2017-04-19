//
//  CAKeyframeAnimationViewController.m
//  CoreAnimationDemo
//
//  Created by dashuios126 on 17/1/9.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

#import "CAKeyframeAnimationViewController.h"

@interface CAKeyframeAnimationViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIView *keyframeAnimationView;

@end

@implementation CAKeyframeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    /*
     CAKeyframeAnimation 是CAPropertyAnimation子类，与CABasicAnimation 的区别是:CABasicAnimation只能从一个数值(fromValue)变到另一个数值(toValue)，而CAKeyframeAnimation会使用一个NSArray保存这些数值
     
     属性： 1.values 里面的元素称为”关键帧”(keyframe)。动画对象会在指定的时间(duration)内，依次显示values数组中的每一个关键帧
     
           2.path 可以设置一个CGPathRef\CGMutablePathRef,让层跟着路径移动。path只对CALayer的anchorPoint和position起作用。如果你设置了path，那么values将被忽略
     
           3. keyTimes：可以为对应的关键帧指定对应的时间点,其取值范围为0到1.0,keyTimes中的每一个时间值都对应values中的每一帧.当keyTimes没有设置的时候,各个关键帧的时间是平分的
            
     - keyPath可以使用的key

     - #define angle2Radian(angle) ((angle)/180.0*M_PI)

     - transform.rotation.x 围绕x轴翻转 参数：角度 angle2Radian(4)

     transform.rotation.y 围绕y轴翻转 参数：同上

     transform.rotation.z 围绕z轴翻转 参数：同上

     transform.rotation 默认围绕z轴

     transform.scale.x x方向缩放 参数：缩放比例 1.5

     transform.scale.y y方向缩放 参数：同上

     transform.scale.z z方向缩放 参数：同上

     transform.scale 所有方向缩放 参数：同上

     transform.translation.x x方向移动 参数：x轴上的坐标 100

     transform.translation.y x方向移动 参数：y轴上的坐标

     transform.translation.z x方向移动 参数：z轴上的坐标

     transform.translation 移动 参数：移动到的点 （100，100）

     opacity 透明度 参数：透明度 0.5

     backgroundColor 背景颜色 参数：颜色 (id)[[UIColor redColor] CGColor]

     cornerRadius 圆角 参数：圆角半径 5

     borderWidth 边框宽度 参数：边框宽度 5

     bounds 大小 参数：CGRect

     contents 内容 参数：CGImage

     contentsRect 可视内容 参数：CGRect 值是0～1之间的小数

     hidden 是否隐藏

     position

     shadowColor
     
     shadowOffset
     
     shadowOpacity
     
     shadowRadius

     */

//    [self keyframeAnimationWithValues];

    [self keyframeAnimationWithKeyPath];
}

- (void)keyframeAnimationWithValues{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 20, 20)];
    view.backgroundColor = [UIColor cyanColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;


    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animation];
    keyframeAnimation.keyPath = @"position";
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(10, 400)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(200, 100)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(300, 400)];
//    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(300, 400)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(200, 100)];
    NSValue *value6 = [NSValue valueWithCGPoint:CGPointMake(10, 400)];
    keyframeAnimation.values = @[value1,value2,value3,value5,value6];


//    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(100, 200)];
//    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(200, 200)];
//    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(200, 400)];
//    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(100, 400)];
//    NSValue *value5=[NSValue valueWithCGPoint:CGPointMake(100, 200)];
//    keyframeAnimation.values = @[value1,value2,value3,value4,value5];
    keyframeAnimation.repeatCount= MAXFLOAT;//MAXFLOAT
    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.fillMode = kCAFillModeForwards;
    keyframeAnimation.duration = 4.0f;
    keyframeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    keyframeAnimation.delegate = self;
//    [self.keyframeAnimationView.layer addAnimation:keyframeAnimation forKey:nil];

    [view.layer addAnimation:keyframeAnimation forKey:nil];
    [self.view addSubview:view];
}

- (void)keyframeAnimationWithKeyPath{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 20, 20)];
    view.backgroundColor = [UIColor cyanColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;

    /*

     */
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 100, 200, 100));//
    CGPathAddRect(path, NULL, CGRectMake(100, 100, 100, 100));
    animation.path = path;
    CGPathRelease(path);
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 4.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    [view.layer addAnimation:animation forKey:nil];
    [self.view addSubview:view];
}

#pragma mark  CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim{

    NSLog(@"start...");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    NSLog(@"stop %d",flag);
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
