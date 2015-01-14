//
//  RPPrinterManager.h
//  Pods
//
//  Created by Martín Fernández on 1/8/15.
//
//

#import <Foundation/Foundation.h>

@interface RPPrinterManager : NSObject

/**
 *  Searches for printers in the LAN and Bluetooth
 *
 *  @param completion The block called when operation finishes
 *
 */
+ (void)searchForPrintersWithCompletionBlock:(void (^) (NSArray *printers))completion;

@end
