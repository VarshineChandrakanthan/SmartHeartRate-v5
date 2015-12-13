//
//  AddPatientViewController.m
//  RecipeBook
//
//  Created by Varshine Chandrakanthan on 15/04/14.
//
//

#import "AddPatientViewController.h"
#import "RecipeBookViewController.h"
#import <Parse/parse.h>


@interface AddPatientViewController ()

@end

@implementation AddPatientViewController
@synthesize firstNameLabel,lastCheckUpLabel,lastNameLabel,dosageLabel,contactnoLabel,docUser,medicationLabel,adddressLabel,patientIDLabel,priorityLabel,genderLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scrollView setContentSize:self.view.frame.size];
}

- (IBAction)backgroundTapp:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)submitClicked:(id)sender {
    
    PFObject *add = [PFObject objectWithClassName:@"Patient"];
    if([firstNameLabel.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Fill in First Name!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
 
    }
    else
    {
        if([genderLabel.text isEqualToString:@""])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Fill in Last Name!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
        else
        {
            if([patientIDLabel.text isEqualToString:@""])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Fill in PatientID!"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
 
            }
            else
            {
                add[@"firstName"]=firstNameLabel.text;
                //add[@"lastName"]=lastNameLabel.text;
                add[@"lastCheckUp"]=lastCheckUpLabel.text;
                add[@"Dosage"]=dosageLabel.text;
                add[@"DocUserName"]=docUser;
                add[@"priority"]=priorityLabel.text;
                add[@"gender"]=genderLabel.text;
                NSString *myString = medicationLabel.text;
                NSArray *myWords = [myString componentsSeparatedByString:@","];
                add[@"medications"]=myWords;
                NSString *myString2 = adddressLabel.text;
                NSArray *myWords2 = [myString2 componentsSeparatedByString:@","];
                add[@"Address2"]=myWords2;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Patient"
                                                            message:@"Successfully added!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
                [alert show];
                NSString *myString3=contactnoLabel.text;
                NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
                [f setNumberStyle:NSNumberFormatterDecimalStyle];
                NSNumber * myNumber = [f numberFromString:myString3];
                add[@"contactno"]=myNumber;
                add[@"patID"]=patientIDLabel.text;
                //[f release];
                //NSString *a = contactnoLabel.text;
                //NSInteger c = [a integerValue];
                //NSNumber *b = [NSNumber numberWithInteger:c];
                //add[@"contactno"]=b;
                [add saveInBackground];
            }
            
        }
        
    }
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [textField resignFirstResponder];
    return YES;
}

- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
    
}

- (void)keyboardWasShown:(NSNotification *)notification {
    
    NSDictionary* info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect frame = self.view.bounds;
    frame.size.height -=keyboardSize.height;
    
    self.scrollView.frame = frame;
    
    return;
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {

    self.scrollView.frame = self.view.bounds;;
    
    return;
}

@end
