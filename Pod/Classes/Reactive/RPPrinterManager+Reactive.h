//
//  RPPrinterManager.h
//  Pods
//
//  Created by Martín Fernández on 1/8/15.
//
//

#import <Foundation/Foundation.h>

#import "RPPrinterManager.h"

@class RACSignal;

@interface RPPrinterManager (Reactive)

/**
*  Searches for printers in the LAN and Bluetooth
*
*  @return Signal with the printers
*/
+ (RACSignal *)searchForPrinters;

/**
 *  Searches for printer in the given Address
 *
 *  @return Signal with the printer
 */
+ (RACSignal *)searchForPrinterAtAddress:(NSString *)address;

@end
