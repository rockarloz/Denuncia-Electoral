//
//  ListViewController.m
//  DenunciaElectoral
//
//  Created by Carlos Castellanos on 20/05/15.
//  Copyright (c) 2015 Carlos Castellanos. All rights reserved.
//

#import "ListViewController.h"
#import <AFHTTPRequestOperationManager.h>
#import "DetailViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController
{
    NSMutableArray *types;
    UITableViewCell *cell ;
}
@synthesize table,scroll;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initElements];
    [self getData];
    // Do any additional setup after loading the view.
}
-(void)initElements{
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    scroll.backgroundColor=[UIColor colorWithRed:252/255.0 green:242/255.0 blue:217/255.0 alpha:1];
    [self.view addSubview:scroll];
    
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 200)];
    img.image=[UIImage imageNamed:[NSString stringWithFormat:@"%i.png",_type]];
    [scroll addSubview: img];
    
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, img.frame.size.height+ img.frame.origin.y, self.view.frame.size.width, 400)];
    table.dataSource=self;
    table.delegate=self;
    
    [scroll addSubview: table];
    
    

}

-(void)getData{
    
    types=[[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://dc.netoxico.com/api/types/?format=json"]];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"netoxico" password:@"123456"];
    
    NSString *url =[NSString stringWithFormat:@"http://dc.netoxico.com/api/types/?format=json"];
    
    [manager GET:url parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        for (NSDictionary *item in responseObject) {
           
            if ([item[@"category"] floatValue]==_type) {
                [types addObject:item];
            }
            
        }
        if ([types count]) {
            // Succes Get data :D
            [table reloadData];
            CGFloat heightAux=0;
            for (NSDictionary *content in types) {
                NSString* text=[content objectForKey:@"name"];
                CGSize constraint = CGSizeMake(300 - (10 * 2), 20000.0f);
                // remember change this method for ios  8 :D :P
                
                CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14]      constrainedToSize:constraint lineBreakMode: NSLineBreakByWordWrapping];
                
                CGFloat height = MAX(size.height, 44.0f);
                
                
                
                height= height + (10 * 2);
                heightAux=heightAux+height;
                
            }
           
            
            
            //heightAux *= types.count;
            
            CGRect tableFrame = self.table.frame;
            tableFrame.size.height = heightAux;
            self.table.frame = tableFrame;
            
        }
        else{
            // No Success :(
        }
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error %@", error);
        [self getData];
        
        
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [types count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor=[UIColor clearColor];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if ([types count]>0) {
        cell.textLabel.numberOfLines=5;
        cell.textLabel.text = [[types objectAtIndex:indexPath.row]objectForKey:@"name"];

    }
    
    
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get the text for indexPath
   // CGSize size = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    //return size.height;
    //return UITableViewAutomaticDimension;
   NSString* text=[[types objectAtIndex:indexPath.row]objectForKey:@"name"];
    CGSize constraint = CGSizeMake(300 - (10 * 2), 20000.0f);
    // remember change this method for ios  8 :D :P
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14]      constrainedToSize:constraint lineBreakMode: NSLineBreakByWordWrapping];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    
    
    return height + (10 * 2);
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    DetailViewController *detail=[[DetailViewController alloc]init];
    
    detail.type=_type ;
    [self.navigationController pushViewController:detail animated:NO];
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
