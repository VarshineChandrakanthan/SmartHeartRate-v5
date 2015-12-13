//
//  CorePlotExampleViewController.m
//  RecipeBook
//
//  Created by Varshine Chandrakanthan on 19/04/14.
//
//

#import "CorePlotExampleViewController.h"
#import <Parse/parse.h>

@interface CorePlotExampleViewController ()

@end

@implementation CorePlotExampleViewController
@synthesize pulseValue,pulseString;

- (void)viewDidLoad
{
    [super viewDidLoad];
    CPTGraphHostingView* hostView = [[CPTGraphHostingView alloc] initWithFrame:self.view.frame];
    [self.view addSubview: hostView];
    
    CPTGraph* graph = [[CPTXYGraph alloc] initWithFrame:hostView.bounds];
    hostView.hostedGraph = graph;
    
    // Get the (default) plotspace from the graph so we can set its x/y ranges
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    // Note that these CPTPlotRange are defined by START and LENGTH (not START and END) !!
    [plotSpace setYRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( 0 ) length:CPTDecimalFromFloat( 16 )]];
    [plotSpace setXRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( -4 ) length:CPTDecimalFromFloat( 8 )]];
    
    // Create the plot (we do not define actual x/y values yet, these will be supplied by the datasource...)
    CPTScatterPlot* plot = [[CPTScatterPlot alloc] initWithFrame:CGRectZero];
    
    // Let's keep it simple and let this class act as datasource (therefore we implemtn <CPTPlotDataSource>)
    plot.dataSource = self;
    
    // Finally, add the created plot to the default plot space of the CPTGraph object we created before
    [graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plotnumberOfRecords {
    return 9; // Our sample graph contains 9 'points'
}

// This method is here because this class also functions as datasource for our graph
// Therefore this class implements the CPTPlotDataSource protocol
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    // We need to provide an X or Y (this method will be /Users/varshine/Desktop/CorePlotExample/CorePlotExamplecalled for each) value for every index
    int x = index - 4;
    NSNumber *z = [NSNumber numberWithInt:x ];
    //int myNumber;
    // This method is actually called twice per point in the plot, one for the X and one for the Y value
    if(fieldEnum == CPTScatterPlotFieldX)
    {
        // Return x value, which will, depending on index, be between -4 to 4
        return [NSNumber numberWithInt: x];
    }
    else
    {
        /*PFQuery *query = [PFQuery queryWithClassName:@"HeartRate"];
        [query whereKey:@"index" equalTo:z];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                
                NSLog(@"Successfully retrieved %d scores.", objects.count);
                for (PFObject *object in objects) {
                    NSLog(@"%@", object.objectId);
                    pulseString=object[@"pulse"];
                    pulseValue = [pulseString intValue];
                    printf("%d",pulseValue);
                    
                }
            } else {
                
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];*/
        
        
        //return [NSNumber numberWithInt: ];
       // return [NSNumber numberWithInt: 5];
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
