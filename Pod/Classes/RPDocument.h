//
//  RPDocument.h
//  Pods
//
//  Created by Martín Fernández on 1/7/15.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(u_int8_t, RPDocumentTopMargin) {
  RPDocumentTopMarginDefault  = '0',
  RPDocumentTopMarginSmall    = '1',
  RPDocumentTopMarginStandard = '2',
};

typedef NS_ENUM(u_int8_t, RPDocumentRasterSpeed) {
  RPDocumentRasterSpeedFull   = '0',
  RPDocumentRasterSpeedMedium = '1',
  RPDocumentRasterSpeedLow    = '2',
};

typedef NS_ENUM(u_int8_t, RPDocumentEndMode) {
  RPDocumentEndModeDefault = '0',
  RPDocumentEndModeNone = '1',
  RPDocumentEndModeFeedToCutter = '2',
  RPDocumentEndModeFeedToTearbar = '3',
  RPDocumentEndModeFullCut = '8',
  RPDocumentEndModeFeedAndFullCut = '9',
};

//TODO: Missing options
//
//    RPDocumentEndModePartialCut,
//    RPDocumentEndModeFeedAndPartialCut,
//    RPDocumentEndModeEject,
//    RPDocumentEndModeFeedAndEject,


@interface RPDocument : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) RPDocumentTopMargin topMargin;
@property (nonatomic, assign) RPDocumentRasterSpeed speed;
@property (nonatomic, assign) RPDocumentEndMode endOfPageMode;
@property (nonatomic, assign) RPDocumentEndMode endOfDocumentMode;
@property (nonatomic, assign) int pageLength;
@property (nonatomic, assign) int leftMarging;
@property (nonatomic, assign) int rightMargin;

/**
 *  Generates an image representation of the document
 *
 *  @return The image
 */
- (UIImage *)generateImage;

@end
