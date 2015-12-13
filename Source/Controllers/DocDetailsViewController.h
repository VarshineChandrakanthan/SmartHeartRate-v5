//
//  DocDetailsViewController.h
//  RecipeBook
//
//  Created by Varshine Chandrakanthan on 19/04/14.
//
//

#import <UIKit/UIKit.h>

@interface DocDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *secondNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *specialLabel;

@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
- (IBAction)ClickMe:(id)sender;

@property NSString *patName;
@property NSString *docName;
@end
