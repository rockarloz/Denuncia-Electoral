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
/*
-(void)getImage{
    NSData *imageToUpload = UIImageJPEGRepresentation(uploadedImgView.image, 1.0);//(uploadedImgView.image);
    if (imageToUpload)
    {
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:keyParameter, @"keyName", nil];
        
        AFHTTPClient *client= [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://------"]];
        
        NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:@"API name as you have" parameters:parameters constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
            [formData appendPartWithFileData: imageToUpload name:@"image" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
        }];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSDictionary *jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
             //NSLog(@"response: %@",jsons);
             
         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             if([operation.response statusCode] == 403)
             {
                 //NSLog(@"Upload Failed");
                 return;
             }
             //NSLog(@"error: %@", [operation error]);
             
         }];
        
        [operation start];
    }
}*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
