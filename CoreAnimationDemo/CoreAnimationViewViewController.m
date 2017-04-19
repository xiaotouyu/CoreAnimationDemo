//
//  CoreAnimationViewViewController.m
//  CoreAnimationDemo
//
//  Created by dashuios126 on 17/1/6.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

#import "CoreAnimationViewViewController.h"
#import <AdSupport/AdSupport.h>

#import "SAMKeychain.h"
#import "SAMKeychainQuery.h"

@interface CoreAnimationViewViewController ()
@property (weak, nonatomic) IBOutlet UIButton *coreAnimationView;
@property (weak, nonatomic) IBOutlet UIButton *cardView;
@property (weak, nonatomic) IBOutlet UIButton *drawView;

@end

@implementation CoreAnimationViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.




//    [self animationWithPosition];
//    [self animationWithRotation];

//    [self animationWithTransition];

    [self animationWithBounds];

//    [self animationWithScale];


//    UIDevice *device = [UIDevice currentDevice];
//    NSString *identifierdeviceString = [[[UIDevice currentDevice] identifierForVendor] UUIDString];//98173424-9A4A-46B6-AA3F-20B4EEED8776
//    NSString *uuid = [[NSUUID UUID] UUIDString];
//    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//
//    NSLog(@"ASIdentifierManager:  %@  uuid: %@  deviceString: %@",adId,uuid,identifierdeviceString);
//    NSString *identifierString = [self getUniqueDeviceIdentifierAsString];//98173424-9A4A-46B6-AA3F-20B4EEED8776  98173424-9A4A-46B6-AA3F-20B4EEED8776
//    NSLog(@"ASIdentifierManager:  %@  uuid: %@  identifierString: %@ deviceString: %@",adId,uuid,identifierString,identifierdeviceString);

}
-(NSString *)getUniqueDeviceIdentifierAsString
{
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];

    NSString *strApplicationUUID =  [SAMKeychain passwordForService:appName account:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];

        NSError *error = nil;
        SAMKeychainQuery *query = [[SAMKeychainQuery alloc] init];
        query.service = appName;
        query.account = @"incoding";
        query.password = strApplicationUUID;
        query.synchronizationMode = SAMKeychainQuerySynchronizationModeNo;
        [query save:&error];

    }

    return strApplicationUUID;
}

#pragma mark 基础动画 （CABasicAnimation）

- (void)animationWithBounds{

    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    [imageView setFrame:CGRectMake(100, 50, 100, 100)];


    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
//    CABasicAnimation  *animation = [CABasicAnimation animationWithKeyPath:@"bounds.origin.x"];

    animation.toValue = @(105);
//    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(100, 50)];
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 50)];
    animation.duration = 1.0;
    animation.repeatCount = 5;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [self.coreAnimationView.layer addAnimation:animation forKey:nil];
    [imageView.layer addAnimation:animation forKey:nil];
    [self.view addSubview:imageView];
}

#pragma mark 平移
#pragma mark position
- (void)animationWithPosition{

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
//    animation.toValue = [NSValue valueWithCGPoint:self.coreAnimationView.center];
    NSLog(@"%f",CGRectGetMinX(self.coreAnimationView.frame) + CGRectGetHeight(self.coreAnimationView.bounds)/2);
    animation.toValue = @(105);
    animation.duration = 1.0;
//    animation.repeatCount = 5;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.cardView.layer addAnimation:animation forKey:nil];
}
#pragma mark rotation 旋转
- (void)animationWithRotation{

//    CABasicAnimation *rorationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    CABasicAnimation *rorationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    CABasicAnimation *rorationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rorationAnimation.duration = 3.0;
    rorationAnimation.repeatCount = 1;
    rorationAnimation.toValue = [NSNumber numberWithFloat:M_PI];
    rorationAnimation.removedOnCompletion = NO;
    rorationAnimation.fillMode = kCAFillModeForwards;

    [self.coreAnimationView.layer addAnimation:rorationAnimation forKey:nil];
}
#pragma mark translationAnimation 平移
- (void)animationWithTransition{
//    CABasicAnimation *translationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    CABasicAnimation *translationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    translationAnimation.duration = 3.0;
    translationAnimation.repeatCount = 1;
//    translationAnimation.toValue = [NSNumber numberWithFloat:-100];
    translationAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    translationAnimation.removedOnCompletion = NO;
    translationAnimation.fillMode = kCAFillModeForwards;

    [self.cardView.layer addAnimation:translationAnimation forKey:nil];

}
#pragma mark 缩放
- (void)animationWithScale{
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

    [self.coreAnimationView.layer addAnimation:pulse forKey:nil];
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
