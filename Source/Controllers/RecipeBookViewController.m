//
//  RecipeBookViewController.m
//  RecipeBook
//
//  Created by Simon Ng on 14/6/12.
//  Copyright (c) 2012 Appcoda. All rights reserved.
//

#import "RecipeBookViewController.h"
#import "RecipeDetailViewController.h"
#import "Recipe.h"
#import "AddPatientViewController.h"

@interface RecipeBookViewController ()

@end

@implementation RecipeBookViewController {
    NSArray *recipes;
    
}
@synthesize passedUser;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Initialize table data
    /*Recipe *recipe1 = [Recipe new];
    recipe1.firstName = @"Anusha";
    recipe1.lastName = @"Cool";
    recipe1.imageFile = @"heart_beat.jpg";
    recipe1.medications = [NSArray arrayWithObjects:@"2 fresh English muffins", @"4 eggs", @"4 rashers of back bacon", @"2 egg yolks", @"1 tbsp of lemon juice", @"125 g of butter", @"salt and pepper", nil];
    
    Recipe *recipe2 = [Recipe new];
    recipe2.firstName = @"Mushroom Risotto";
    recipe2.lastName = @"30 min";
    recipe2.imageFile = @"heart_beat.jpg";
    recipe2.medications = [NSArray arrayWithObjects:@"1 tbsp dried porcini mushrooms", @"2 tbsp olive oil", @"1 onion, chopped", @"2 garlic cloves", @"350g/12oz arborio rice", @"1.2 litres/2 pints hot vegetable stock", @"salt and pepper", @"25g/1oz butter", nil];
    
    Recipe *recipe3 = [Recipe new];
    recipe3.firstName = @"Full Breakfast";
    recipe3.lastName = @"20 min";
    recipe3.imageFile = @"heart_beat.jpg";
    recipe3.medications = [NSArray arrayWithObjects:@"2 sausages", @"100 grams of mushrooms", @"2 rashers of bacon", @"2 eggs", @"150 grams of baked beans", @"Vegetable oil", nil];
    
    Recipe *recipe4 = [Recipe new];
    recipe4.firstName = @"Hamburger";
    recipe4.lastName = @"30 min";
    recipe4.imageFile = @"hamburger.jpg";
    recipe4.medications = [NSArray arrayWithObjects:@"400g of ground beef", @"1/4 onion (minced)", @"1 tbsp butter", @"hamburger bun", @"1 teaspoon dry mustard", @"Salt and pepper", nil];
    
    Recipe *recipe5 = [Recipe new];
    recipe5.firstName = @"Ham and Egg Sandwich";
    recipe5.lastName = @"10 min";
    recipe5.imageFile = @"ham_and_egg_sandwich.jpg";
    recipe5.medications = [NSArray arrayWithObjects:@"1 unsliced loaf (1 pound) French bread", @"4 tablespoons butter", @"2 tablespoons mayonnaise", @"8 thin slices deli ham", @"1 large tomato, sliced", @"1 small onion", @"8 eggs", @"8 slices cheddar cheese", nil];
    

    
    
    recipes = [NSArray arrayWithObjects:recipe1, recipe2, recipe3, recipe4, recipe5, nil];*/
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipes count];
}*/

/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Recipe *recipe = [recipes objectAtIndex:indexPath.row];
    
    //UIImageView *imageView = (UIImageView*) [cell viewWithTag:100];
    //imageView.image = [UIImage imageNamed:recipe.imageFile];
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    nameLabel.text = recipe.firstName;
    //UILabel *prepTimeLabel = (UILabel*) [cell viewWithTag:102];
    //prepTimeLabel.text = recipe.lastName;
    
    return cell;
}*/


/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RecipeDetailViewController *destViewController = segue.destinationViewController;
        destViewController.recipe = [recipes objectAtIndex:indexPath.row];
    }
}*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RecipeDetailViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        Recipe *recipe = [[Recipe alloc] init];
        recipe.firstName = [object objectForKey:@"firstName"];
        recipe.lastName = [object objectForKey:@"lastName"];
        recipe.imageFile=@"heart_beat.jpg";
        //recipe.patID = [object objectForKey:@"patID"];
        recipe.medications = [object objectForKey:@"medications"];
        recipe.priority=[object objectForKey:@"priority"];
        destViewController.recipe = recipe;
        
    }
    else if ([segue.identifier isEqualToString:@"addSegue"] )
    {
        AddPatientViewController *addpatient = segue.destinationViewController;
        addpatient.docUser=passedUser;

    }


}


- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"Patient";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"firstName";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
    }
    return self;
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query whereKey:@"DocUserName" equalTo:passedUser];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;

    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    // Configure the cell
    //PFFile *thumbnail = [object objectForKey:@"imageFile"];
    //PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    //thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    //thumbnailImageView.file = thumbnail;
    //[thumbnailImageView loadInBackground];
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    nameLabel.text = [object objectForKey:@"firstName"];
    
    UILabel *prepTimeLabel = (UILabel*) [cell viewWithTag:102];
    prepTimeLabel.text = [object objectForKey:@"priority"];
    
    return cell;
}


- (IBAction)addPatient:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"addSegue" sender:self];
    
        
    

}
@end
