//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by dashuios126 on 17/1/4.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,weak) UIView *ViewTest;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
     核心动画中所有的类都遵循CAMediaTiming协议
     CAAnaimation是个抽象类，本身不具备动画效果，必须使用其自类
     CAAnimationGroup和CATransition才具有动画效果，CAAnimationGroup是个动画组，可以同时进行缩放,旋转(同时进行多个动画).
     CATransition 是转场动画，界面之间跳转（切换）都可以使用转场动画
     CAPropertyAnimation 也是个抽象类，本身不具备动画效果，其子类才具有
     CABasicAnimation 和 CAKeyframeAnimation:
     CABasicAnimation 基本动画，做一些简单动画
     CAKeyframeAnimation帧动画，做一些连贯流畅的动画
     
     CABasicAnimation 属性：
     removedOnCompletion  完成后是否回到原来状态，如果为NO 就是停留在动画结束时的状态
     fillMode  kCAFillModeBackwards  当动画完成时，保留在动画结束的状态 kCAFillModeRemoved 动画完成后返回到原来状态
     
     autoreverses  当你设定这个属性为 YES 时,在它到达目的地之后,动画的返回到开始的值,代替了直接跳转到 开始的值
     */

    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 20, 20)];
    aView.backgroundColor = [UIColor redColor];
    aView.layer.cornerRadius = 10;
    aView.layer.masksToBounds = YES;
    [self.view addSubview:aView];
    self.ViewTest = aView;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 100)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 100)];
    animation.duration = 3.0f;
    animation.repeatCount = 1;
//    animation.speed = 0.4;
    animation.removedOnCompletion = NO; //完成后是否回到原来状态，如果为NO 就是停留在动画结束时的状态
    //animation.fillMode = kCAFillModeRemoved;//动画完成后返回到原来状态
    //animation.fillMode = kCAFillModeBackwards;
    animation.fillMode = kCAFillModeForwards;//当动画完成时，保留在动画结束的状态

//    [aView.layer addAnimation:animation forKey:nil];

//    [self opacityForever_Animation:1.0];
//
//    [self animateCicleAlongPath];
//
//    [self drawACurvedLine];

//    [self animation01];
    [self animation02];
}

- (void)animation01{

    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:
                               @"transform.scale"
                               ];

    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    pulse.duration = 0.5 + (rand() % 10) * 0.05;

    pulse.repeatCount = 10;
    //当你设定这个属性为 YES 时,在它到达目的地之后,动画的返回到开始的值,代替了直接跳转到 开始的值。
    pulse.autoreverses = YES;

    pulse.fromValue = [NSNumber numberWithFloat:.8];

    pulse.toValue = [NSNumber numberWithFloat:2.0];
    
    [self.ViewTest.layer addAnimation:pulse forKey:nil];
}

- (void)animation02{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation.duration = 1.0;
    animation.repeatCount = 5;
    animation.autoreverses = YES;
    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 20, 20)];
    animation.byValue = [NSValue valueWithCGRect:CGRectMake(75, 300, 20,20)];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 120,20)];
    [self.ViewTest.layer addAnimation:animation forKey:nil];
}

- (void)opacityForever_Animation:(float)time {

    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.0];
    animation.autoreverses=YES;
    animation.duration=time;
    animation.repeatCount = FLT_MAX;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;

    [self.ViewTest.layer addAnimation:animation forKey:@"opacityForever"];
}

-(void)animateCicleAlongPath
{
    //准备关键帧动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 5.0f;
    pathAnimation.repeatCount = 200;
    //pathAnimation.autoreverses = YES; //原路返回，而不是从头再来
    //设置动画路径
    //CGPoint endPoint = CGPointMake(310, 450);
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, 10, 10);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 10, 450, 310, 450);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 310, 10, 10, 10);
    //已经有了路径，我们要告诉动画  路径
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);  //这里要手工释放

    [self.ViewTest.layer addAnimation:pathAnimation forKey:nil];
    
}


-(void)drawACurvedLine
{
    UIGraphicsBeginImageContext(CGSizeMake(320, 460));
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, 3);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    //设置起点
    CGContextMoveToPoint(context, 10, 10);

    CGContextAddQuadCurveToPoint(context, 10, 450, 310, 450);
    CGContextAddQuadCurveToPoint(context, 310, 10, 10, 10);
//    CGContextAddLineToPoint(context, 100, 10);
//    CGContextAddLineToPoint(context, 100, 100);
//    CGContextAddLineToPoint(context, 10, 100);

    //划线
    CGContextDrawPath(context, kCGPathStroke);

    //得到一个image 从目前的矢量上下文
    UIImage *curve = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIImageView *curveView = [[UIImageView alloc]initWithImage:curve];
    curveView.frame = CGRectMake(1, 100, 320, 460);
    curveView.backgroundColor = [UIColor cyanColor];
//    [curveView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:curveView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
