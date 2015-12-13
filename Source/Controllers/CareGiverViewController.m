//
//  CareGiverViewController.m
//  RecipeBook
//
//  Created by Varshine Chandrakanthan on 15/04/14.
//
//

#import "CareGiverViewController.h"
#import <Parse/parse.h>
#import "MoreOnPatientViewController.h"
#import "CorePlotViewController.h"
#import "DocDetailsViewController.h"
#import "Recipe.h"

@interface CareGiverViewController ()

@end

@implementation CareGiverViewController
@synthesize caregiverName,patientName;

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
    NSLog(@"%@",caregiverName);
    PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
    [query whereKey:@"CareGiverName" equalTo:caregiverName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error)
        {
            for(PFObject *object in objects)
            {
                patientName = object[@"firstName"];
                NSLog(@"%@",patientName);
            }
        }
        else
            NSLog(@"Error");
    }];

    
    /*
     PFObject *object = [self.objects objectAtIndex:indexPath.row];
     Recipe *recipe = [[Recipe alloc] init];
     recipe.firstName = [object objectForKey:@"firstName"];
     recipe.lastName = [object objectForKey:@"lastName"];
     recipe.imageFile=@"heart_beat.jpg";
     //recipe.patID = [object objectForKey:@"patID"];
     recipe.medications = [object objectForKey:@"medications"];
     destViewController.recipe = recipe;
     */
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

- (IBAction)PatientDetailsClicked:(id)sender {
    //[self performSegueWithIdentifier:@"Crazy" sender:self];
}

- (IBAction)DoctorDetailsClicked:(id)sender {
    //[self performSegueWithIdentifier:@"DocDets" sender:self];
    
    
}

- (IBAction)showGraph:(id)sender {
    //[self performSegueWithIdentifier:@"CareGiverGraph" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"Crazy"]){
        MoreOnPatientViewController *morOn=[segue destinationViewController];
        morOn.patientName=patientName;
      
    }
    else if ([[segue identifier] isEqualToString:@"DocDets"])
    {
        DocDetailsViewController *docdetails = [segue destinationViewController];
        docdetails.patName=patientName;
    }
    
   
    
}
     

    

@end
