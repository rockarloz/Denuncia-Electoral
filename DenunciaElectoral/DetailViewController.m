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
}


@synthesize scroll;
- (void)viewDidLoad {
    delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [self initElements];
    float latitude = delegate.locationManager.location.coordinate.latitude;
    float longitude = delegate.locationManager.location.coordinate.longitude;
    // Do any additional setup after loading the view.
    [self getImage];
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

-(void)getImage{
    
    UIImage *image = [UIImage imageNamed:@"1.png"];//[info valueForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    self.params = @{@"name":@"anonimo", @"last_name":@"anonimo", @"content":@"texto", @"latitude":@10.343, @"longitude":@-34.324, @"phone":@9611510936 , @"ip":[self getIPAddress], @"is_active":@true  };
    
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"netoxico" password:@"123456"];
    
    [manager POST:@"http://dc.netoxico.com/api/complaints/" parameters:self.params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFormData:imageData name:@"image"];
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

@end
