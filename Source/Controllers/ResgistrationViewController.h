//
//  ResgistrationViewController.h
//  RecipeBook
//
//  Created by Varshine Chandrakanthan on 12/04/14.
//
//

#import <UIKit/UIKit.h>

@interface ResgistrationViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passText;
- (IBAction)SignUpClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong) NSArray *typeList;
- (IBAction)bckTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *patientIDText;
@end
