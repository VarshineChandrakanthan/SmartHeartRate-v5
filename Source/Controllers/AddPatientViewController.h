//
//  AddPatientViewController.h
//  RecipeBook
//
//  Created by Varshine Chandrakanthan on 15/04/14.
//
//

#import <UIKit/UIKit.h>

@interface AddPatientViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *lastNameLabel;

@property (weak, nonatomic) IBOutlet UITextField *lastCheckUpLabel;

@property (weak, nonatomic) IBOutlet UITextField *dosageLabel;

@property (weak, nonatomic) IBOutlet UITextField *contactnoLabel;
@property (strong) NSString *docUser;
@property (weak, nonatomic) IBOutlet UITextField *medicationLabel;
@property (weak, nonatomic) IBOutlet UITextField *adddressLabel;
- (IBAction)backgroundTapp:(id)sender;

- (IBAction)submitClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *patientIDLabel;
@property (weak, nonatomic) IBOutlet UITextField *genderLabel;
@property (weak, nonatomic) IBOutlet UITextField *priorityLabel;






@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *submit;


@end
