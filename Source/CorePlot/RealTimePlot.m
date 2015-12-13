//
//  RealTimePlot.m
//  CorePlotGallery
//

#import "RealTimePlot.h"
#import <Parse/Parse.h>

static const double kFrameRate = 5.0;  // frames per second
static const double kAlpha     = 0.25; // smoothing constant

static const NSUInteger kMaxDataPoints = 52;
static NSString *const kPlotIdentifier = @"Data Source Plot";

@interface RealTimePlot()

@property (nonatomic, strong) NSDate *updatedDate;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) BOOL cancelFetch;

@end

@implementation RealTimePlot
@synthesize count;
+(void)load
{
    [super registerPlotItem:self];
}

-(id)init
{
    if ( (self = [super init]) ) {
        plotData  = [[NSMutableArray alloc] initWithCapacity:kMaxDataPoints];
        dataTimer = nil;

        self.title   = @"Hear Beat Real Time Plot";
        self.section = kLinePlots;
    }

    return self;
}

-(void)killGraph
{
    self.cancelFetch = YES;
    
    [dataTimer invalidate];
    [dataTimer release];
    dataTimer = nil;

    [super killGraph];
}

-(void)generateData
{
    [plotData removeAllObjects];
    currentIndex = 0;
}

-(void)renderInLayer:(CPTGraphHostingView *)layerHostingView withTheme:(CPTTheme *)theme animated:(BOOL)animated
{
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
    CGRect bounds = layerHostingView.bounds;
#else
    CGRect bounds = NSRectToCGRect(layerHostingView.bounds);
#endif

    CPTGraph *graph = [[[CPTXYGraph alloc] initWithFrame:bounds] autorelease];
    [self addGraph:graph toHostingView:layerHostingView];
    [self applyTheme:theme toGraph:graph withDefault:[CPTTheme themeNamed:kCPTDarkGradientTheme]];

    [self setTitleDefaultsForGraph:graph withBounds:bounds];
    [self setPaddingDefaultsForGraph:graph withBounds:bounds];

    graph.plotAreaFrame.paddingTop    = 15.0;
    graph.plotAreaFrame.paddingRight  = 15.0;
    graph.plotAreaFrame.paddingBottom = 55.0;
    graph.plotAreaFrame.paddingLeft   = 55.0;
    graph.plotAreaFrame.masksToBorder = NO;

    // Grid line styles
    CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle];
    majorGridLineStyle.lineWidth = 0.75;
    majorGridLineStyle.lineColor = [[CPTColor colorWithGenericGray:0.2] colorWithAlphaComponent:0.75];

    CPTMutableLineStyle *minorGridLineStyle = [CPTMutableLineStyle lineStyle];
    minorGridLineStyle.lineWidth = 0.25;
    minorGridLineStyle.lineColor = [[CPTColor whiteColor] colorWithAlphaComponent:0.1];

    // Axes
    // X axis
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x          = axisSet.xAxis;
    x.labelingPolicy              = CPTAxisLabelingPolicyAutomatic;
    x.orthogonalCoordinateDecimal = CPTDecimalFromUnsignedInteger(0);
    x.majorGridLineStyle          = majorGridLineStyle;
    x.minorGridLineStyle          = minorGridLineStyle;
    x.minorTicksPerInterval       = 9;
    x.title                       = @"Time Interval";
    x.titleOffset                 = 35.0;
    NSNumberFormatter *labelFormatter = [[NSNumberFormatter alloc] init];
    labelFormatter.numberStyle = NSNumberFormatterNoStyle;
    x.labelFormatter           = labelFormatter;
    [labelFormatter release];

    // Y axis
    CPTXYAxis *y = axisSet.yAxis;
    y.labelingPolicy              = CPTAxisLabelingPolicyEqualDivisions;
    y.orthogonalCoordinateDecimal = CPTDecimalFromUnsignedInteger(0);
    y.majorGridLineStyle          = majorGridLineStyle;
    y.minorGridLineStyle          = minorGridLineStyle;
    y.minorTicksPerInterval       = 5;
    y.labelOffset                 = 5.0;
    y.title                       = @"Heart Beat Rate";
    y.titleOffset                 = 30.0;
    y.axisConstraints             = [CPTConstraints constraintWithLowerOffset:0.0];

    // Rotate the labels by 45 degrees, just to show it can be done.
    x.labelRotation = M_PI_4;

    // Create the plot
    CPTScatterPlot *dataSourceLinePlot = [[[CPTScatterPlot alloc] init] autorelease];
    dataSourceLinePlot.identifier     = kPlotIdentifier;
    dataSourceLinePlot.cachePrecision = CPTPlotCachePrecisionDouble;

    CPTMutableLineStyle *lineStyle = [[dataSourceLinePlot.dataLineStyle mutableCopy] autorelease];
    lineStyle.lineWidth              = 3.0;
    lineStyle.lineColor              = [CPTColor greenColor];
    dataSourceLinePlot.dataLineStyle = lineStyle;

    dataSourceLinePlot.dataSource = self;
    [graph addPlot:dataSourceLinePlot];

    // Plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromUnsignedInteger(0) length:CPTDecimalFromUnsignedInteger(kMaxDataPoints - 2)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromUnsignedInteger(0) length:CPTDecimalFromUnsignedInteger(1)];

    [dataTimer invalidate];
    [dataTimer release];

    self.updatedDate = [NSDate date];
    [self fetchDataFromServer];
}

-(void)dealloc
{
    [plotData release];
    [dataTimer invalidate];
    [dataTimer release];

    [super dealloc];
}

#pragma mark -
#pragma mark Timer callback

- (void)fetchDataFromServer
{
    if (!self.cancelFetch) {
        return;
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"HeartRate"];
#warning Give Actual user name
    [query whereKey:@"patID" equalTo:@"Doctor123"];
    [query whereKey:@"createdAt" greaterThan:self.updatedDate];
    [query setLimit:1];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for (PFObject *object in objects) {
            
            CGFloat value = [[object valueForKey:@"pulse2"] floatValue];
            
            CPTGraph *theGraph = (self.graphs)[0];
            CPTPlot *thePlot   = [theGraph plotWithIdentifier:kPlotIdentifier];
            
            if ( thePlot ) {
                
                if ( plotData.count >= kMaxDataPoints ) {
                    [plotData removeObjectAtIndex:0];
                    [thePlot deleteDataInIndexRange:NSMakeRange(0, 1)];
                }
                
                CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)theGraph.defaultPlotSpace;
                NSUInteger location       = (currentIndex >= kMaxDataPoints ? currentIndex - kMaxDataPoints + 2 : 0);
                
                CPTPlotRange *oldRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromUnsignedInteger( (location > 0) ? (location - 1) : 0 )
                                                                      length:CPTDecimalFromUnsignedInteger(kMaxDataPoints - 2)];
                CPTPlotRange *newRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromUnsignedInteger(location)
                                                                      length:CPTDecimalFromUnsignedInteger(kMaxDataPoints - 2)];
                
                [CPTAnimation animate:plotSpace
                             property:@"xRange"
                        fromPlotRange:oldRange
                          toPlotRange:newRange
                             duration:CPTFloat(1.0 / kFrameRate)];
                
                currentIndex++;
                [plotData addObject:@( (1.0 - kAlpha) * [[plotData lastObject] doubleValue] + kAlpha * value / 1024)];
                [thePlot insertDataAtIndex:plotData.count - 1 numberOfRecords:1];
            }
            
            break;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self fetchDataFromServer];
        });
    }];
    
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Network Failure"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];*/
    //[alert show];

    //Update Date to last fetch Date
    [self setUpdatedDate:[NSDate date]];
}

-(void)newData:(NSTimer *)theTimer
{

}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [plotData count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSNumber *num = nil;
    switch ( fieldEnum ) {
        case CPTScatterPlotFieldX:
            num = @(index + currentIndex - plotData.count);
            break;

        case CPTScatterPlotFieldY:
            num = plotData[index];
            break;

        default:
            break;
    }
        return num;
}

@end
