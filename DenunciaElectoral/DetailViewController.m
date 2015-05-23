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
}


@synthesize scroll;
- (void)viewDidLoad {
    delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [self initElements];
    float latitude = delegate.locationManager.location.coordinate.latitude;
    float longitude = delegate.locationManager.location.coordinate.longitude;
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

    
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-60, 20, 120, 120)];
    img.image=[UIImage imageNamed:[NSString stringWithFormat:@"%i.png",_type]];
    [scroll addSubview: img];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, img.frame.size.height+ img.frame.origin.y+15, self.view.frame.size.width, 40)];
    lbl.text=_name;
    lbl.backgroundColor=[UIColor clearColor];
    lbl.textAlignment=NSTextAlignmentCenter;
    [scroll addSubview: lbl];
    
   
    
    UILabel *lbl2=[[UILabel alloc]initWithFrame:CGRectMake(10, lbl.frame.size.height+lbl.frame.origin.y, self.view.frame.size.width-45, 50)];
    lbl2.text=_data[@"name"];
    lbl2.numberOfLines=4;
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
    
    send.frame = CGRectMake(self.view.frame.size.width-60, description.frame.size.height+description.frame.origin.y, 50, 30);
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

- (void)collectData {
  
   // self.params = @{@"name":@"anonimo", @"last_name":@"anonimo", @"content":description.text, @"latitude":self.genderLabel.text, @"longitude":gradeAux, @"phone":[[NSUUID UUID] UUIDString], @"ip":[self getIPAddress], @"picture": explanationAux, @"is_active":true  };
    [self sendData];
}

-(void)sendData{
  
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"netoxico" password:@"123456"];
    [manager POST:@"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/testimonios" parameters:self.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"¡Gracias!" message:@"Gracias por enviar tu testimonio" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Compartir", nil];
        [alert setTag:1];
        [alert show];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];


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
    self.params = @{@"name":@"anonimo", @"last_name":@"anonimo", @"content":description.text, @"latitude":@10.343, @"longitude":@-34.324, @"ip":[self getIPAddress], @"is_active":@true ,@"uuid":[[NSUUID UUID] UUIDString],@"complaint_type": @7,@"picture":imageData};
    
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"netoxico" password:@"123456"];
    
    [manager POST:@"http://dc.netoxico.com/api/complaints/" parameters:self.params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
 
        [formData appendPartWithFileData:imageData name:@"picture" fileName:@"prueba.png" mimeType:@"image/jpeg"];
        
    }
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
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
