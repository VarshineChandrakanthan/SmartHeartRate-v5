//
//  DocDetailsViewController.m
//  RecipeBook
//
//  Created by Varshine Chandrakanthan on 19/04/14.
//
//

#import "DocDetailsViewController.h"
#import <Parse/parse.h>

@interface DocDetailsViewController ()

@end

@implementation DocDetailsViewController
@synthesize patName,docName,firstNameLabel,secondNameLabel,contactLabel,specialLabel;

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
    NSLog(@"Pat name : %@",patName);
    PFQuery *query =[PFQuery queryWithClassName:@"Patient"];
    [query whereKey:@"firstName" equalTo:patName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if(!error)
         {
             NSLog(@"Successful!");
             for(PFObject *object in objects)
             {
                 docName = object[@"DocUserName"];
                 NSLog(@"%@",docName);
             }
         }
         else
             NSLog(@"Error!");
     }];
    
    

   // NSLog(@"%@",patName);
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

- (IBAction)ClickMe:(id)sender {
    PFQuery *query2 = [PFQuery queryWithClassName:@"DoctorDetails"];
    [query2 whereKey:@"FName" equalTo:docName];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects2, NSError *error) {
        
        if(!error)
        {
            NSLog(@"Successful!");
            for(PFObject *object2 in objects2)
            {
                NSString *Lname=object2[@"LName"];
                NSLog(@"%@",Lname);
                firstNameLabel.text = object2[@"FName"];
                secondNameLabel.text = object2[@"LName"];
                specialLabel.text = object2[@"Specialization"];
                NSNumber *mynum= object2[@"ContactNo"];
                NSString *myStr = [NSString stringWithFormat:@"%@",mynum];
                contactLabel.text=myStr;
                
            }
        }
        else
            NSLog(@"Error!");
        
    }];

    
    
}
@end
