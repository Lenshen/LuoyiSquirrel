//
//  NavigationViewController.m
//  LuoYi
//
//  Created by 远深 on 16/3/30.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "NavigationViewController.h"
#import "UIImage+Image.h"


@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.enabled = YES;

    self.navigationBar.barTintColor = NavigationColor;
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};

//    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]
//                                                 forBarPosition:UIBarPositionAny
//                                                     barMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[UIImage new]];

//    
//    CGRect frame = self.navigationBar.frame;
//｀
//    
//    _alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height+20)];
//    _alphaView.backgroundColor = [UIColor blueColor];
//    [self.view insertSubview:_alphaView belowSubview:self.navigationBar];
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsCompact];
//    self.navigationBar.layer.masksToBounds = YES;

    
    
}

-(void)setAlph{

     if (_changing == NO) {
        _changing = YES;
        if (_alphaView.alpha == 0.0 ) {
            [UIView animateWithDuration:0.5 animations:^{
                _alphaView.alpha = 1.0;
            } completion:^(BOOL finished) {
                _changing = NO;
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                _alphaView.alpha = 0.0;
            } completion:^(BOOL finished) {
                _changing = NO;
                
            }];
        }
    }
    
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
