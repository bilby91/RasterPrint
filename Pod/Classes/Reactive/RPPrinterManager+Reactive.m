//
//  RPPrinterManager.m
//  Pods
//
//  Created by Martín Fernández on 1/8/15.
//
//

#import "RPPrinterManager.h"

#import <ReactiveCocoa/RACSignal.h>
#import <ReactiveCocoa/RACSubscriber.h>
#import <StarIO/SMPort.h>

#import "RPPrinter.h"

@implementation RPPrinterManager (Reactive)

+ (RACSignal *)searchForPrinters {
  return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    [self searchForPrintersWithCompletionBlock:^(NSArray *printers) {
      [subscriber sendNext:printers];
    }];

    return nil;
  }];
}

@end
