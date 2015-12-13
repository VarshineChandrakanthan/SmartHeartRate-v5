//
//  RealTimePlot.h
//  CorePlotGallery
//

#import "PlotItem.h"

@interface RealTimePlot : PlotItem<CPTPlotDataSource>
{
    @private
    NSMutableArray *plotData;
    NSUInteger currentIndex;
    NSTimer *dataTimer;
}
@property NSInteger count;
-(void)newData:(NSTimer *)theTimer;

@end
