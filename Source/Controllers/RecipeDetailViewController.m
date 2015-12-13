//
//  RecipeDetailViewController.m
//  RecipeBook
//
//  Created by Simon Ng on 17/6/12.
//  Copyright (c) 2012 Appcoda. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "MoreOnPatientViewController.h"

@interface RecipeDetailViewController ()

@end

@implementation RecipeDetailViewController

@synthesize recipePhoto;
@synthesize prepTimeLabel;
@synthesize ingredientTextView;
@synthesize recipe;
@synthesize pN;

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
    
    self.title = recipe.firstName;
    pN=recipe.firstName;
    self.prepTimeLabel.text = recipe.priority;
    self.recipePhoto.image = [UIImage imageNamed:recipe.imageFile];

    NSMutableString *ingredientText = [NSMutableString string];
    for (NSString* ingredient in recipe.medications) {
        [ingredientText appendFormat:@"%@\n", ingredient];
    }
    self.ingredientTextView.text = ingredientText;
    
}

- (void)viewDidUnload
{
    [self setRecipePhoto:nil];
    [self setPrepTimeLabel:nil];
    [self setIngredientTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)moreOnClicked:(id)sender {
    [self performSegueWithIdentifier:@"moreOn" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"moreOn"]){
        MoreOnPatientViewController *mop = [segue destinationViewController];
        mop.patientName=pN;
        //RecipeBookViewController *rc=[segue destinationViewController];
        //rc.passedUser=userText.text;
    }
    
}
@end
