//
//  CareGiverViewController.h
//  RecipeBook
//
//  Created by Varshine Chandrakanthan on 15/04/14.
//
//

#import <UIKit/UIKit.h>

@interface CareGiverViewController : UIViewController
@property (strong) NSString *caregiverName;
@property (strong) NSString *patientName;

- (IBAction)PatientDetailsClicked:(id)sender;

- (IBAction)DoctorDetailsClicked:(id)sender;
- (IBAction)showGraph:(id)sender;


@end
