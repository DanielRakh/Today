//
//  VectorGraphic.m
//
//  Created by Michael Maxwell on 12/6/13.
//  Copyright (c) 2013 Michael Maxwell. All rights reserved.
//

#import "MMScalableVectorView.h"

@interface MMScalableVectorView ()
@property (nonatomic, copy) void (^drawingBlock)();
@property (nonatomic, assign) CGSize originalSize;
@end

@implementation MMScalableVectorView

- (id)initWithFrame:(CGRect)frame drawingBlock:(void (^)(void))drawingBlock originalSize:(CGSize)originalSize
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.drawingBlock = drawingBlock;
        self.originalSize = originalSize;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [self applyCTMTransformsForContext:context frame:self.bounds];
    [self drawInCurrentContext];
    CGContextRestoreGState(context);
}

- (void)drawInFrame:(CGRect)frame
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [self applyCTMTransformsForContext:context frame:frame];
    [self drawInCurrentContext];
    CGContextRestoreGState(context);

}

- (UIImage *)getImageWithSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self applyCTMTransformsForContext:UIGraphicsGetCurrentContext() frame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    [self drawInCurrentContext];
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return returnImage;
}

- (void)applyCTMTransformsForContext:(CGContextRef)context frame:(CGRect)frame
{
    CGSize graphicSize = self.originalSize;
    CGSize viewSize = frame.size;

    // Translate by the origin of the frame to begin with.
    CGContextTranslateCTM(context, frame.origin.x, frame.origin.y);
    
    switch(self.contentMode)
    {
        case UIViewContentModeScaleToFill:
            // Simple scale
            CGContextScaleCTM(context, viewSize.width/graphicSize.width, viewSize.height/graphicSize.height);
            break;
        case UIViewContentModeScaleAspectFit:
        {
            CGFloat scale = MIN(viewSize.width/graphicSize.width, viewSize.height/graphicSize.height);
            CGContextTranslateCTM(context, (viewSize.width-(graphicSize.width*scale))/2.0f, (viewSize.height-(graphicSize.height*scale))/2.0f);
            CGContextScaleCTM(context, scale, scale);
            break;
        }
        case UIViewContentModeScaleAspectFill:     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
        {
            CGFloat scale = MAX(viewSize.width/graphicSize.width, viewSize.height/graphicSize.height);
            CGContextTranslateCTM(context, (viewSize.width-(graphicSize.width*scale))/2.0f, (viewSize.height-(graphicSize.height*scale))/2.0f);
            CGContextScaleCTM(context, scale, scale);
            break;
        }
        case UIViewContentModeRedraw:              // redraw on bounds change (calls -setNeedsDisplay)
            break;
        case UIViewContentModeCenter:              // contents remain same size. positioned adjusted.
            CGContextTranslateCTM(context, (viewSize.width-graphicSize.width)/2.0f, (viewSize.height-graphicSize.height)/2.0f);
            break;
        case UIViewContentModeTop:
            break;
        case UIViewContentModeBottom:
            CGContextTranslateCTM(context, 0.0f, viewSize.height-graphicSize.height);
            break;
        case UIViewContentModeLeft:
            break;
        case UIViewContentModeRight:
            CGContextTranslateCTM(context, viewSize.width-graphicSize.width, 0.0f);
            break;
        case UIViewContentModeTopLeft:
            break;
        case UIViewContentModeTopRight:
            CGContextTranslateCTM(context, viewSize.width-graphicSize.width, 0.0f);
            break;
        case UIViewContentModeBottomLeft:
            CGContextTranslateCTM(context, 0.0f, viewSize.height-graphicSize.height);
            break;
        case UIViewContentModeBottomRight:
            CGContextTranslateCTM(context, viewSize.width-graphicSize.width, viewSize.height-graphicSize.height);
            break;
    }
}

- (void)drawInCurrentContext
{
    self.drawingBlock();
}

@end
