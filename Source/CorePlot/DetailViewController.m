//
//  DetailViewController.m
//  CorePlotGallery
//
//  Created by Jeff Buck on 8/28/10.
//  Copyright Jeff Buck 2010. All rights reserved.
//

#import "DetailViewController.h"
#import "RealTimePlot.h"

#define kThemeTableViewControllerNoTheme      @"None"
#define kThemeTableViewControllerDefaultTheme @"Default"

@interface DetailViewController()

@property (nonatomic, retain) UIPopoverController *popoverController;

@end

@implementation DetailViewController

@synthesize toolbar;
@synthesize popoverController;
@dynamic detailItem;
@synthesize hostingView;
@synthesize currentThemeName;

#pragma mark -
#pragma mark Initialization and Memory Management


-(void)dealloc
{
    [popoverController release];
    [toolbar release];
    [detailItem release];
    [hostingView release];

    [super dealloc];
}

-(CPTTheme *)currentTheme
{
    CPTTheme *theme;
    
    if ( [currentThemeName isEqualToString:kThemeTableViewControllerNoTheme] ) {
        theme = (id)[NSNull null];
    }
    else if ( [currentThemeName isEqualToString:kThemeTableViewControllerDefaultTheme] ) {
        theme = nil;
    }
    else {
        theme = [CPTTheme themeNamed:currentThemeName];
    }
    
    return theme;
}


#pragma mark -
#pragma mark Managing the detail item

-(PlotItem *)detailItem
{
    return detailItem;
}

-(void)setDetailItem:(id)newDetailItem
{
    if ( detailItem != newDetailItem ) {
        [detailItem killGraph];
        [detailItem release];

        detailItem = [newDetailItem retain];
        [detailItem renderInView:hostingView withTheme:[self currentTheme] animated:YES];
    }

    if ( popoverController != nil ) {
        [popoverController dismissPopoverAnimated:YES];
    }
}

#pragma mark -
#pragma mark Split view support

-(void)splitViewController:(UISplitViewController *)svc
    willHideViewController:(UIViewController *)aViewController
         withBarButtonItem:(UIBarButtonItem *)barButtonItem
      forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = @"Plot Gallery";
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}

-(void)   splitViewController:(UISplitViewController *)svc
       willShowViewController:(UIViewController *)aViewController
    invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    NSMutableArray *items = [[toolbar items] mutableCopy];

    [items removeObjectAtIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = nil;
}

#pragma mark -
#pragma mark Rotation support

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if ( UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad ) {
        self.hostingView.frame = self.view.bounds;
    }
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PlotItem *plotItem = [[RealTimePlot alloc] init];

    self.detailItem = plotItem;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    themeBarButton.title = currentThemeName;
}

-(void)viewDidUnload
{
    self.popoverController = nil;
}

-(void)themeSelectedAtIndex:(NSString *)themeName
{
    [detailItem renderInView:hostingView withTheme:[self currentTheme] animated:YES];
}

@end
