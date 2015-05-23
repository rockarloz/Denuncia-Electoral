//
//  DetailViewController.m
//  Pods
//
//  Created by Carlos Castellanos on 20/05/15.
//
//

#import "DetailViewController.h"
#import <AFHTTPRequestOperationManager.h>

#include <ifaddrs.h>
#include <arpa/inet.h>
#import "AppDelegate.h"
@interface DetailViewController ()
@property (nonatomic, retain) NSDictionary *params;
@end

@implementation DetailViewController

{
    UITextView *description;
    AppDelegate *delegate;
    UIButton *camera;
    UIButton *send;
    NSString *latitude;
    NSString *longitude;
}


@synthesize scroll;
- (void)viewDidLoad {
    
    self.navigationController.topViewController.navigationItem.title=@"El delito fue Qga:";
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor yellowColor],NSForegroundColorAttributeName,
                                    [UIFont fontWithName:@"Akkurat" size:21],NSFontAttributeName,nil];
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
    self.navigationController.navigationBar.backItem.title=@"";
    delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [self initElements];
    latitude = [NSString stringWithFormat:@"%f", delegate.locationManager.location.coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f",delegate.locationManager.location.coordinate.longitude ];
    // Do any additional setup after loading the view.

}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.backItem.title=@"";
    self.navigationController.topViewController.navigationItem.title=@"El delito fue Qga:";
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor yellowColor],NSForegroundColorAttributeName,
                                    [UIFont fontWithName:@"Akkurat" size:21],NSFontAttributeName,nil];
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;

}
-(void)initElements{
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    scroll.backgroundColor=[UIColor colorWithRed:252/255.0 green:242/255.0 blue:217/255.0 alpha:1];
    [self.view addSubview:scroll];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                    initWithTarget:self
                                    action:@selector(dismissKeyboard)];
    
    [scroll addGestureRecognizer:tap];

    
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-60, 20, 120, 120)];
    img.image=[UIImage imageNamed:[NSString stringWithFormat:@"%i.png",_type]];
    [scroll addSubview: img];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, img.frame.size.height+ img.frame.origin.y+15, self.view.frame.size.width, 40)];
    lbl.text=_name;
    lbl.backgroundColor=[UIColor clearColor];
    lbl.textColor=[UIColor colorWithRed:86/255.0 green:119/255.0 blue:174/255.0 alpha:1];
    lbl.textAlignment=NSTextAlignmentCenter;
    [scroll addSubview: lbl];
    
   
    
    UILabel *lbl2=[[UILabel alloc]initWithFrame:CGRectMake(10, lbl.frame.size.height+lbl.frame.origin.y, self.view.frame.size.width-45, 50)];
    lbl2.text=_data[@"name"];
    lbl2.numberOfLines=4;
    lbl2.textColor=[UIColor lightGrayColor];
    lbl2.backgroundColor=[UIColor clearColor];
    [lbl2 sizeToFit];
    lbl2.textAlignment=NSTextAlignmentCenter;
    

        lbl2.frame=CGRectMake((self.view.frame.size.width/2)-(lbl2.frame.size.width/2)-10, lbl.frame.size.height+lbl.frame.origin.y, lbl2.frame.size.width, lbl2.frame.size.height);
    [scroll addSubview: lbl2];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [button addTarget:self
               action:@selector(moreInfo:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"" forState:UIControlStateNormal];
    button.frame = CGRectMake(lbl2.frame.size.width+2+lbl2.frame.origin.x, lbl.frame.size.height+lbl.frame.origin.y+(lbl2.frame.size.height/2 -15), 30, 30);
    [scroll addSubview:button];
    
    
    UILabel *lbl3=[[UILabel alloc]initWithFrame:CGRectMake(10, lbl2.frame.size.height+lbl2.frame.origin.y+10, self.view.frame.size.width-20, 30)];
    lbl3.text=@"Explica un poco más";
    lbl3.textColor=[UIColor colorWithRed:86/255.0 green:119/255.0 blue:174/255.0 alpha:1];
    lbl3.backgroundColor=[UIColor clearColor];
    
    [scroll addSubview: lbl3];
    
    
    
    description=[[UITextView alloc]initWithFrame:CGRectMake(10, lbl3.frame.size.height+lbl3.frame.origin.y, self.view.frame.size.width-20, 200)];
    description.delegate=self;
    description.scrollEnabled=NO;
    
    [scroll addSubview: description];
    
    camera = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [camera addTarget:self
               action:@selector(takePhoto:)
     forControlEvents:UIControlEventTouchUpInside];
    [camera setTitle:@"" forState:UIControlStateNormal];
    
      camera.frame = CGRectMake(10, description.frame.size.height+description.frame.origin.y, 50, 30);
    [scroll addSubview:camera];
    
    _preview=[[UIImageView alloc]initWithFrame:CGRectMake(50, description.frame.size.height+description.frame.origin.y, 50, 50)];
     [scroll addSubview:_preview];
    
    send = [UIButton buttonWithType:UIButtonTypeCustom];
    [send addTarget:self
               action:@selector(send:)
     forControlEvents:UIControlEventTouchUpInside];
    [send setTitle:@"Enviar" forState:UIControlStateNormal];
   
    send.titleLabel.textColor=[UIColor colorWithRed:86/255.0 green:119/255.0 blue:174/255.0 alpha:1];
    send.frame = CGRectMake(self.view.frame.size.width-70, description.frame.size.height+description.frame.origin.y, 50, 30);
    [scroll addSubview:send];
    
    
    
    
    
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



- (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

-(IBAction)send:(id)sender{
    
    UIImage *image = _preview.image;//[info valueForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    self.params = @{@"name":@"anonimo", @"last_name":@"anonimo", @"content":description.text, @"latitude":latitude, @"longitude":longitude, @"ip":[self getIPAddress], @"is_active":@true ,@"uuid":[[NSUUID UUID] UUIDString],@"complaint_type": @7,@"picture":imageData};
    
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"netoxico" password:@"123456"];
    
    [manager POST:@"http://dc.netoxico.com/api/complaints/" parameters:self.params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
 
        [formData appendPartWithFileData:imageData name:@"picture" fileName:@"prueba.png" mimeType:@"image/jpeg"];
        
    }
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"Gracias por mandar tu denuncia" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alert show];
            [self.navigationController popViewControllerAnimated:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"Ocurrio un error intentalo de nuevo" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)moreInfo:(id)sender{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"" message:_data[@"description"] delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
    camera.frame = CGRectMake(10, textView.frame.size.height+textView.frame.origin.y, 50, 30);
    _preview.frame = CGRectMake(50, textView.frame.size.height+textView.frame.origin.y, 50, 30);
    send.frame = CGRectMake(self.view.frame.size.width-70, textView.frame.size.height+textView.frame.origin.y, 50, 30);
    
    [scroll setContentSize:CGSizeMake(self.view.frame.size.width, _preview.frame.size.height+_preview.frame.origin.y+20)];
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}
#pragma camera delegates methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.preview.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
