//
//  RPViewController.m
//  RasterPrint
//
//  Created by okit on 01/07/2015.
//  Copyright (c) 2014 okit. All rights reserved.
//

#import "RPViewController.h"

#import <RasterPrint/RPPrinter.h>
#import <RasterPrint/RPPrinterManager.h>
#import <RasterPrint/RPDocument.h>
#import <RasterPrint/RPImageRasterizer.h>

@interface NSString (Printing)

- (NSString *)br;
- (NSString *)line:(NSString *)newLine;
- (NSString *)alignLeftWithSpace:(NSUInteger)space;
- (NSString *)alignRightWithSpace:(NSUInteger)space;
- (NSString *)alignCenterWithSpace:(NSUInteger)space;
- (NSString *)appendCharacter:(char)character times:(NSUInteger)times;

@end

@implementation NSString (Printing)

- (NSString *)br {
  return [self stringByAppendingString:@"\n"];
}

- (NSString *)line:(NSString *)newLine {
  return [self stringByAppendingString:newLine];
}

- (NSString *)alignLeftWithSpace:(NSUInteger)space {
  NSUInteger leftSpace = space - self.length;

  if (leftSpace == 0) {
    return self;
  }

  if (leftSpace > 0) {
    return [self appendCharacter:' ' times:leftSpace];
  }

  return [[self substringWithRange:NSMakeRange(0, leftSpace - 3)]stringByAppendingString:@"..."];
}

- (NSString *)alignRightWithSpace:(NSUInteger)space {
  NSUInteger leftSpace = space - self.length;

  if (leftSpace == 0) {
    return self;
  }

  if (leftSpace > 0) {
    return [[@"" appendCharacter:' ' times:leftSpace] stringByAppendingString:self];
  }

  return [[self substringWithRange:NSMakeRange(0, leftSpace - 3)]stringByAppendingString:@"..."];
}

- (NSString *)alignCenterWithSpace:(NSUInteger)space {
  NSUInteger leftSpace = space - self.length;

  if (leftSpace == 0) {
    return self;
  }

  if (leftSpace > 0) {
    return [[[@"" appendCharacter:' ' times:(leftSpace / 2)]
                  stringByAppendingString:self]
            appendCharacter:' ' times:(leftSpace / 2 + leftSpace%2)];
  }

  return [[self substringWithRange:NSMakeRange(0, leftSpace - 3)] stringByAppendingString:@"..."];
}

- (NSString *)appendCharacter:(char)character times:(NSUInteger)times {
  return [self stringByAppendingString:[self.class stringWithRepeatCharacter:character times:times]];
}

+ (NSString *)stringWithRepeatCharacter:(char)character times:(NSUInteger)times {
  char repeatString[times + 1];
  memset(repeatString, character, times);

  repeatString[times] = 0;

  return [NSString stringWithCString:repeatString encoding:NSUTF8StringEncoding];
}

@end

@interface RPViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation RPViewController

- (IBAction)printButtonPressed:(id)sender {
  [self print];
}

- (void)print {
  [RPPrinterManager searchForPrinterAtAddress:@"tcp:192.168.1.6" completionBlock:^(RPPrinter *printer) {
    if (printer) {
      RPDocument *docuement = [self document];
      [printer printDocument:docuement];
      self.imageView.image = [docuement generateImage];
    }
  }];
}

- (RPDocument *)document {
  RPDocument *document = [[RPDocument alloc] init];

  document.text =  @"        Star Clothing Boutique\r\n"
  "             123 Star Road\r\n"
  "           City, State 12345\r\n"
  "\r\n"
  "Date: MM/DD/YYYY         Time:HH:MM PM\r\n"
  "--------------------------------------\r\n"
  "SALE\r\n"
  "SKU            Description       Total\r\n"
  "300678566      PLAIN T-SHIRT     10.99\n"
  "300692003      BLACK DENIM       29.99\n"
  "300651148      BLUE DENIM        29.99\n"
  "300642980      STRIPED DRESS     49.99\n"
  "30063847       BLACK BOOTS       35.99\n"
  "\n"
  "Subtotal                        156.95\r\n"
  "Tax                               0.00\r\n"
  "--------------------------------------\r\n"
  "Total                          $156.95\r\n"
  "--------------------------------------\r\n"
  "\r\n"
  "Charge\r\n159.95\r\n"
  "Visa XXXX-XXXX-XXXX-0123\r\n"
  "Refunds and Exchanges\r\n"
  "Within 30 days with receipt\r\n"
  "And tags attached\r\n";

  document.speed = RPDocumentRasterSpeedMedium;
  document.endOfPageMode = RPDocumentEndModeFeedAndFullCut;
  document.endOfDocumentMode = RPDocumentEndModeFeedAndFullCut;
  document.topMargin = RPDocumentTopMarginStandard;
  document.leftMarging = 2;
  document.rightMargin = 0;
  document.pageLength  = 0;

  return document;
}

@end
