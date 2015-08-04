//
//  ImageRasterizer.h
//  Pods
//
//  Created by Martín Fernández on 1/8/15.
//
//

#import <UIKit/UIKit.h>

@class RPDocument;

@interface RPImageRasterizer : NSObject

/**
 *  Generates the raster command and raw data(pixels of the image) for the given document
 *
 *  @param document The document to print
 *
 *  @return The pixels
 */
+ (NSData *)pixelsForDocument:(RPDocument *)document;

/**
 *  Generates the raster command and raw data(pixels of the image) for the given image
 *
 *  @param document The document to print
 *
 *  @return The pixels
 */
+ (NSData *)pixelsForImage:(UIImage *)image;

@end
