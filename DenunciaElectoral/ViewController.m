//
//  ViewController.m
//  DenunciaElectoral
//
//  Created by Carlos Castellanos on 20/05/15.
//  Copyright (c) 2015 Carlos Castellanos. All rights reserved.
//

#import "ViewController.h"
#import "ListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    self.navigationController.topViewController.navigationItem.title=@"Denuncias a:";
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIFont fontWithName:@"OpenSans-Bold" size:21],NSFontAttributeName,nil];
    
    self.navigationController.navigationBar.tintColor=[UIColor yellowColor];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;

    //[self.navigationController.navigationBar setBarTintColor:[UIColor yellowColor]];
    self.view.backgroundColor=[UIColor colorWithRed:252/255.0 green:242/255.0 blue:217/255.0 alpha:1];
    [super viewDidLoad];
    [self createViews];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)createViews{
    _btn1=[[UIView alloc]initWithFrame:CGRectMake(15, 94, (self.view.frame.size.width-40)/2, 200)];
    UIImageView *img1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _btn1.frame.size.width, _btn1.frame.size.height)];
    img1.image=[UIImage imageNamed:@"1.png"];
    [_btn1 addSubview:img1];
    _btn1.tag=1;
    UITapGestureRecognizer *tapImg1 =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(taptap:)];
    [_btn1 addGestureRecognizer:tapImg1];
    
    
    _btn2=[[UIView alloc]initWithFrame:CGRectMake(15+ (self.view.frame.size.width-40)/2, 94, (self.view.frame.size.width-40)/2, 200)];
    
    UIImageView *img2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _btn2.frame.size.width, _btn2.frame.size.height)];
    img2.image=[UIImage imageNamed:@"2.png"];
    [_btn2 addSubview:img2];
    _btn2.tag=2;
    UITapGestureRecognizer *tapImg2 =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(taptap:)];
    [_btn2 addGestureRecognizer:tapImg2];
    
    _btn3=[[UIView alloc]initWithFrame:CGRectMake(15, 314, (self.view.frame.size.width-40)/2, 200)];
    UIImageView *img3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _btn3.frame.size.width, _btn3.frame.size.height)];
    img3.image=[UIImage imageNamed:@"3.png"];
    [_btn3 addSubview:img3];
    _btn3.tag=3;
    UITapGestureRecognizer *tapImg3 =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(taptap:)];
    [_btn3 addGestureRecognizer:tapImg3];
    
    
    [self.view addSubview:_btn1];
    [self.view addSubview:_btn2];
    [self.view addSubview:_btn3];
    

}

-(void)taptap:(UIGestureRecognizer *)gestureRecognizer {
    UIView *tappedView = [gestureRecognizer.view hitTest:[gestureRecognizer locationInView:gestureRecognizer.view] withEvent:nil];
    ListViewController *list=[[ListViewController alloc]init];
    
    list.type=(int )tappedView.tag ;
    [self.navigationController pushViewController:list animated:NO];
    // do something with it
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
