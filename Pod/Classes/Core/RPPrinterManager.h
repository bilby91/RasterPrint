//
//  RPPrinterManager.h
//  Pods
//
//  Created by Martín Fernández on 1/8/15.
//
//

#import <Foundation/Foundation.h>

@class RPPrinter;

@interface RPPrinterManager : NSObject

/**
 *  Searches for printers in the LAN and Bluetooth
 *
 *  @param completion The block called when operation finishes
 *
 */
+ (void)searchForPrintersWithCompletionBlock:(void (^) (NSArray *printers))completion;

/**
 *  Searches for a printer in the given address.
 *
 *  @param address    The IP address of the printer. Example: @"tpc:192.168.0.10"
 *  @param completion The block called when the printer is found.
 */
+ (void)searchForPrinterAtAddress:(NSString *)address completionBlock:(void (^)(RPPrinter *))completion;

@end
