//
//  RPPrinter.h
//  Pods
//
//  Created by Martín Fernández on 1/8/15.
//
//

#import <Foundation/Foundation.h>

@class PortInfo;
@class RPDocument;

@interface RPPrinter : NSObject

/**
 *  Creates a new printer with the given settings
 *
 *  @param portInfo The printer settings
 *
 *  @return A new printer
 */
- (instancetype)initWithPortInfo:(PortInfo *)portInfo;

/**
 *  Prints the given document synchronously
 *
 *  @param document The document to print
 */
- (void)printDocument:(RPDocument *)document;

@end
