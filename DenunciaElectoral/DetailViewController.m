//
//  DetailViewController.m
//  Pods
//
//  Created by Carlos Castellanos on 20/05/15.
//
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

{
    UITextView *description;
}


@synthesize scroll;
- (void)viewDidLoad {
    [self initElements];
    // Do any additional setup after loading the view.
}
-(void)initElements{
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    scroll.backgroundColor=[UIColor colorWithRed:252/255.0 green:242/255.0 blue:217/255.0 alpha:1];
    [self.view addSubview:scroll];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                    initWithTarget:self
                                    action:@selector(dismissKeyboard)];
    
    [scroll addGestureRecognizer:tap];

    
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 200)];
    img.image=[UIImage imageNamed:[NSString stringWithFormat:@"%i.png",_type]];
    [scroll addSubview: img];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, img.frame.size.height+img.frame.origin.y, self.view.frame.size.width-20, 50)];
    lbl.text=@"Explica un poco más";
    [lbl sizeToFit];
    [scroll addSubview: lbl];
    
    description=[[UITextView alloc]initWithFrame:CGRectMake(10, lbl.frame.size.height+lbl.frame.origin.y, self.view.frame.size.width-20, 200)];
    [scroll addSubview: description];
    
    
    
}
-(void)dismissKeyboard {
    [description resignFirstResponder];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *view in self.view.subviews)
        [view resignFirstResponder];
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
