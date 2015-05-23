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
    self.navigationController.topViewController.navigationItem.title=@"Denuncias Qga:";
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor yellowColor],NSForegroundColorAttributeName,
                                    [UIFont fontWithName:@"BrauerNeue-Regular" size:21],NSFontAttributeName,nil];
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;

    //[self.navigationController.navigationBar setBarTintColor:[UIColor yellowColor]];
    self.view.backgroundColor=[UIColor colorWithRed:252/255.0 green:242/255.0 blue:217/255.0 alpha:1];
    [super viewDidLoad];
    [self createViews];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)createViews{
    
    UIButton *info=[[UIButton alloc]initWithFrame:CGRectMake(0, 50, 20, 20)];
    
    
    _btn1=[[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/4), 94, (self.view.frame.size.width-40)/2, (self.view.frame.size.height-64)/3)];
  
    UIImageView *img1=[[UIImageView alloc]initWithFrame:CGRectMake(_btn1.frame.size.width/2-_btn1.frame.size.height/4, 10, _btn1.frame.size.height/2,  _btn1.frame.size.height/2)];
    img1.image=[UIImage imageNamed:@"1.png"];
    [_btn1 addSubview:img1];
    _btn1.tag=1;
    UILabel *tag1=[[UILabel alloc]initWithFrame:CGRectMake(0, img1.frame.size.height+img1.frame.origin.y, _btn1.frame.size.width, 20)];
    tag1.text=@"Un ciudadano Q";
    [tag1 setFont:[UIFont fontWithName:@"BrauerNeue-Regular" size:21]];
    //[tag1 sizeToFit];
    tag1.textAlignment=NSTextAlignmentCenter;
    [_btn1 addSubview:tag1];
    UITapGestureRecognizer *tapImg1 =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(taptap:)];
    [_btn1 addGestureRecognizer:tapImg1];
    
    
    _btn2=[[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/4), _btn1.frame.size.height+_btn1.frame.origin.y, (self.view.frame.size.width-40)/2, (self.view.frame.size.height-64)/3)];
    
    UIImageView *img2=[[UIImageView alloc]initWithFrame:CGRectMake(_btn2.frame.size.width/2-_btn2.frame.size.height/4, 10, _btn2.frame.size.height/2,  _btn2.frame.size.height/2)];
    img2.image=[UIImage imageNamed:@"2.png"];
    [_btn2 addSubview:img2];
    _btn2.tag=2;
    UILabel *tag2=[[UILabel alloc]initWithFrame:CGRectMake(0, img2.frame.size.height+img2.frame.origin.y, _btn2.frame.size.width, 20)];
    tag2.text=@"Un funcionario";
    //[tag1 sizeToFit];
    tag2.textAlignment=NSTextAlignmentCenter;
    [_btn2 addSubview:tag2];

    UITapGestureRecognizer *tapImg2 =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(taptap:)];
    [_btn2 addGestureRecognizer:tapImg2];
    
    _btn3=[[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/4), _btn2.frame.size.height+_btn2.frame.origin.y, (self.view.frame.size.width-40)/2, (self.view.frame.size.height-64)/3)];

    UIImageView *img3=[[UIImageView alloc]initWithFrame:CGRectMake(_btn3.frame.size.width/2-_btn3.frame.size.height/4, 10, _btn3.frame.size.height/2,  _btn3.frame.size.height/2)];
    img3.image=[UIImage imageNamed:@"3.png"];
    [_btn3 addSubview:img3];
    _btn3.tag=3;
    
    UILabel *tag3=[[UILabel alloc]initWithFrame:CGRectMake(0, img3.frame.size.height+img3.frame.origin.y, _btn2.frame.size.width, 20)];
    tag3.text=@"Un candidato";
    //[tag1 sizeToFit];
    tag3.textAlignment=NSTextAlignmentCenter;
    [_btn3 addSubview:tag3];
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
    if ((int )tappedView.tag==1)
        list.name=@"Un ciudadano";
    else if ((int )tappedView.tag==2)
         list.name=@"Un funcionario";
    else
         list.name=@"Un candidato";
    
    [self.navigationController pushViewController:list animated:NO];
    // do something with it
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.backItem.title=@"";
    self.navigationController.topViewController.navigationItem.title=@"Denuncias a: Qga:";
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor yellowColor],NSForegroundColorAttributeName,
                                    [UIFont fontWithName:@"Akkurat" size:21],NSFontAttributeName,nil];
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
}

@end
