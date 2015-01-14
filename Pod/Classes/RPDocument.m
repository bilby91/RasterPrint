//
//  RPDocument.m
//  Pods
//
//  Created by Martín Fernández on 1/7/15.
//
//

#import "RPDocument.h"

@implementation RPDocument

- (UIImage *)generateImage {
  UIFont *font = [UIFont fontWithName:@"Courier" size:12.f * 2];

  //TODO: 3-Inch
  CGFloat width = 576;

  CGRect rect = [self.text boundingRectWithSize:CGSizeMake(width, INFINITY) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : font } context:NULL];

  UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.f);

  CGContextRef context = UIGraphicsGetCurrentContext();

  CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
  CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);

  CGContextFillRect(context, rect);

  CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
  CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);

  [self.text drawInRect:rect withAttributes:@{ NSFontAttributeName : font }];

  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

  UIGraphicsEndImageContext();

  return image;
}

@end
