//
//  CorePlotExampleViewController.h
//  RecipeBook
//
//  Created by Varshine Chandrakanthan on 19/04/14.
//
//

#import <UIKit/UIKit.h>

#import "Coreplot-CocoaTouch.h"

@interface CorePlotExampleViewController : UIViewController<CPTPlotDataSource>
@property NSInteger pulseValue;
@property NSString *pulseString;
@end




