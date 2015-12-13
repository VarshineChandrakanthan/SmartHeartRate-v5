//
//  LogInViewController.h
//  RecipeBook
//
//  Created by Varshine Chandrakanthan on 12/04/14.
//
//

#import <UIKit/UIKit.h>
#import "RecipeBookViewController.h"

@interface LogInViewController : UIViewController {
    RecipeBookViewController *recipe;
}
@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (strong) NSString *pType;
@property (strong) NSString *passwordCheck;
- (IBAction)SignInClicked:(id)sender;

- (IBAction)bckTapped:(id)sender;

@end
