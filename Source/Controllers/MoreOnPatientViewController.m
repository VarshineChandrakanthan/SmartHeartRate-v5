//
//  MoreOnPatientViewController.m
//  RecipeBook
//
//  Created by Varshine Chandrakanthan on 13/04/14.
//
//

#import "MoreOnPatientViewController.h"
#import <Parse/parse.h>
@interface MoreOnPatientViewController ()

@end

@implementation MoreOnPatientViewController
@synthesize patientName;
@synthesize lastcheckupLabel,dosageLabel,contactnoLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",patientName);
    PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
    [query whereKey:@"firstName" equalTo:patientName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error)
        {
            for(PFObject *object in objects)
            {
                lastcheckupLabel.text=object[@"lastCheckUp"];
                    dosageLabel.text=object[@"Dosage"];
                //contactnoLabel.text=object[@"contactno"];
                //NSInteger someInteger = object[@"contactno"];
               // NSString *someString = [NSString stringWithFormat:@"%i", someInteger];
                //contactnoLabel.text = someString;
                
                 NSMutableString *addressText = [NSMutableString string];
                for(NSString *address in object[@"Address2"])
                {
                    [addressText appendFormat:@"%@\n", address];
                }
                self.addressTextView.text = addressText;
                NSNumber *mynum= object[@"contactno"];
                NSString *myStr = [NSString stringWithFormat:@"%@",mynum];
                contactnoLabel.text=myStr;
                
            }
        }
        else
            NSLog(@"Error");
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
