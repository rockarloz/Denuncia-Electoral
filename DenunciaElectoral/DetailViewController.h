//
//  DetailViewController.h
//  Pods
//
//  Created by Carlos Castellanos on 20/05/15.
//
//

#import "ViewController.h"

@interface DetailViewController : ViewController <UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic,strong)IBOutlet UIScrollView *scroll;
@property (nonatomic,strong)IBOutlet UIImageView *preview;
@property (nonatomic,assign)int type;
@property (nonatomic,strong)NSMutableDictionary *data;
@property (nonatomic,strong)NSString *name;
@end
