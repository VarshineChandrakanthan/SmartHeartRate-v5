#import "CPTPlatformSpecificDefines.h"

@interface CPTImage : NSObject<NSCoding, NSCopying>

@property (nonatomic, readwrite, copy) CPTNativeImage *nativeImage;
@property (nonatomic, readwrite, assign) CGImageRef image;
@property (nonatomic, readwrite, assign) CGFloat scale;
@property (nonatomic, readwrite, assign, getter = isTiled) BOOL tiled;
@property (nonatomic, readwrite, assign) BOOL tileAnchoredToContext;
@property (nonatomic, readonly, getter = isOpaque) BOOL opaque;

/// @name Factory Methods
/// @{
+(instancetype)imageNamed:(NSString *)name;

+(instancetype)imageWithNativeImage:(CPTNativeImage *)anImage;
+(instancetype)imageWithContentsOfFile:(NSString *)path;
+(instancetype)imageWithCGImage:(CGImageRef)anImage scale:(CGFloat)newScale;
+(instancetype)imageWithCGImage:(CGImageRef)anImage;
+(instancetype)imageForPNGFile:(NSString *)path;
/// @}

/// @name Initialization
/// @{
-(instancetype)initWithNativeImage:(CPTNativeImage *)anImage;
-(instancetype)initWithContentsOfFile:(NSString *)path;
-(instancetype)initWithCGImage:(CGImageRef)anImage scale:(CGFloat)newScale;
-(instancetype)initWithCGImage:(CGImageRef)anImage;
-(instancetype)initForPNGFile:(NSString *)path;
/// @}

/// @name Drawing
/// @{
-(void)drawInRect:(CGRect)rect inContext:(CGContextRef)context;
/// @}

@end
