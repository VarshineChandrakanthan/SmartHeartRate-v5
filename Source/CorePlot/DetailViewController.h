//
//  DetailViewController.h
//  CorePlotGallery
//
//  Created by Jeff Buck on 8/28/10.
//  Copyright Jeff Buck 2010. All rights reserved.
//

#import "CorePlot-CocoaTouch.h"
#import "PlotItem.h"
#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UIPopoverControllerDelegate,
                                                   UISplitViewControllerDelegate>
{
    @private
    UIPopoverController *popoverController;
    UIToolbar *toolbar;

    PlotItem *detailItem;

    UIView *hostingView;
    UIBarButtonItem *themeBarButton;
    UIPopoverController *themePopoverController;
    
    NSString *currentThemeName;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) PlotItem *detailItem;
@property (nonatomic, retain) IBOutlet UIView *hostingView;
@property (nonatomic, copy) NSString *currentThemeName;

@end
