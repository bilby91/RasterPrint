//
//  RPPrinterManager.m
//  Pods
//
//  Created by Martín Fernández on 1/8/15.
//
//

#import "RPPrinterManager.h"

#import <StarIO/SMPort.h>

#import "RPPrinter.h"

@implementation RPPrinterManager

+ (void)searchForPrintersWithCompletionBlock:(void (^)(NSArray *))completion {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    NSArray *portsInfo = [SMPort searchPrinter];
    NSMutableArray *printers = [@[] mutableCopy];

    [portsInfo enumerateObjectsUsingBlock:^(PortInfo *portInfo, NSUInteger idx, BOOL *stop) {
      [printers addObject:[[RPPrinter alloc] initWithPortInfo:portInfo]];
    }];

    dispatch_sync(dispatch_get_main_queue(), ^{
      completion(printers);
    });
  });
}


@end
