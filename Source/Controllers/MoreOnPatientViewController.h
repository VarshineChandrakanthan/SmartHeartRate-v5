//
//  MoreOnPatientViewController.h
//  RecipeBook
//
//  Created by Varshine Chandrakanthan on 13/04/14.
//
//

#import <UIKit/UIKit.h>

@interface MoreOnPatientViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lastcheckupLabel;
@property (weak, nonatomic) IBOutlet UILabel *dosageLabel;

@property (weak, nonatomic) IBOutlet UILabel *contactnoLabel;

@property (weak, nonatomic) IBOutlet UITextView *addressTextView;


@property (strong) NSString *patientName;
@end
