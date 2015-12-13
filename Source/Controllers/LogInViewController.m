//
//  LogInViewController.m
//  RecipeBook
//
//  Created by Varshine Chandrakanthan on 12/04/14.
//
//

#import "LogInViewController.h"
#import "RecipeBookViewController.h"
#import <Parse/Parse.h>
#import "CareGiverViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController
@synthesize userText,passwordText,pType,passwordCheck;

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

- (IBAction)SignInClicked:(id)sender {
    NSString *user=userText.text;
    //if([user isEqualToString:@""])
    //{
       // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        //message:@"Invalid Username or Password"
                                                       //delegate:self
                                              //cancelButtonTitle:@"OK"
                                              //otherButtonTitles:nil];
        //[alert show];
    //}
    //else
    //{
        PFQuery *query =[PFQuery queryWithClassName:@"Login"];
        [query whereKey:@"Username" equalTo:user];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
         {
             if(!error)
             {
                 NSLog(@"Successful!");
                 for(PFObject *object in objects)
                 {
                     pType = object[@"UserType"];
                     passwordCheck = object[@"Password"];
                     if([passwordText.text isEqualToString:passwordCheck])
                     {
                
                        NSLog(@"%@",pType);
                        if ([pType isEqualToString:@"Doctor"])
                        {
                                [self performSegueWithIdentifier:@"DocSegue" sender:self];
                    
                        }
                        else
                        {
                            [self performSegueWithIdentifier:@"CareGiverSegue" sender:self];
                        }
                
                     }
                     else
                     {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Invalid Username or Password"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                         [alert show];
                         NSLog(@"Invalid username and password");
                     }
                 }//for brackets
             }
             else
             {
                 NSLog(@"Error");
             }
        
         }];
   // }
   
}

- (IBAction)bckTapped:(id)sender {
    [self.view endEditing:YES];
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"DocSegue"]){
        RecipeBookViewController *rc=[segue destinationViewController];
        rc.passedUser=userText.text;
    }
    else if ([[segue identifier] isEqualToString:@"CareGiverSegue"])
    {
        CareGiverViewController *cg=[segue destinationViewController];
        cg.caregiverName=userText.text;
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [textField resignFirstResponder];
    return YES;
}

@end
