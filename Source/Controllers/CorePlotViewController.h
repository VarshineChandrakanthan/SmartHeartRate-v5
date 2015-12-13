//
//  CorePlotViewController.h
//  RecipeBook
//
//  Created by Varshine Chandrakanthan on 17/04/14.
//
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface CorePlotViewController : UIViewController<CPTPlotDataSource>
@property (nonatomic, strong) CPTGraphHostingView *hostView;
@property (nonatomic) NSInteger pulseValue;
@property NSString* pulseString;
@property NSNumber *myNumber;
@end
