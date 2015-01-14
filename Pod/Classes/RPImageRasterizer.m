//
//  ImageRasterizer.m
//  Pods
//
//  Created by Martín Fernández on 1/8/15.
//
//

#import "RPImageRasterizer.h"

#import "RPDocument.h"

size_t const bitsPerColorComponent  = 8;
u_int8_t const brightnessThreshhold = 127;
int const bytesPerColorComponent    = 4;

typedef struct RPPixel {
  u_int8_t red;
  u_int8_t green;
  u_int8_t blue;
  u_int8_t alpha;
} RPPixel;

#pragma mark - Drawing

CGContextRef CreateBitmapContext(CGImageRef image) {
  size_t width = CGImageGetWidth(image);
  size_t height = CGImageGetHeight(image);

  size_t bytesPerRow = width * bitsPerColorComponent;

  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

  if (colorSpace == NULL) return NULL;

  void *bitmapData = malloc(bytesPerRow * height);

  CGContextRef context = CGBitmapContextCreate(bitmapData,
                                               width,
                                               height,
                                               8,
                                               bytesPerRow,
                                               colorSpace,
                                               (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);

  CGColorSpaceRelease(colorSpace);

  return context;
}

void GenerateImagePixels(CGImageRef image, void *pixels) {
  CGContextRef context = CreateBitmapContext(image);

  if (context == NULL) return;

  size_t width = CGImageGetWidth(image);
  size_t height = CGImageGetHeight(image);

  CGRect rect = CGRectMake(0, 0, width, height);

  CGContextDrawImage(context, rect, image);

  void *rawPixels = CGBitmapContextGetData(context);

  CGContextRelease(context);

  if (rawPixels == NULL) return;

  memcpy(pixels, rawPixels, width * height * sizeof(RPPixel));

  free(rawPixels);

  return;
}

u_int8_t GetPixelBrightness(RPPixel pixel) {
  return (pixel.red + pixel.green + pixel.blue) / 3;
}

NSData* GetRasterDataForImage(CGImageRef image, RPPixel *pixels) {
  NSMutableData *rasterData = [[NSMutableData alloc] init];

  int32_t width  = (int32_t)CGImageGetWidth(image);
  int32_t height = (int32_t)CGImageGetHeight(image);

  int32_t bytesPerRow = width / 8;

  if ((width % 8) != 0) bytesPerRow++;

  u_int8_t *bytes = malloc(3 + bytesPerRow);

  memset(bytes, 0x00, 3 + bytesPerRow);

  for (NSUInteger y = 0; y < height; y++) {

    NSUInteger bitRowPosition = 0;

    for (NSUInteger x = 0; x < bytesPerRow; x++) {

      u_int8_t byte = 0x00;

      for (NSUInteger colorBit = 0; colorBit < bitsPerColorComponent; colorBit++) {

        byte = byte << 1;

        if (bitRowPosition < width) {

          RPPixel pixel            = pixels[(bitRowPosition + (y * width))];
          u_int8_t pixelBirghtness = GetPixelBrightness(pixel);

          if ( pixelBirghtness < brightnessThreshhold) byte |= 0x01;
        }

        bitRowPosition++;
      }

      bytes[3 + x] = byte;
    }

    bytes[0] = 0x62;
    bytes[1] = (u_int8_t) (bytesPerRow % 256);
    bytes[2] = (u_int8_t) (bytesPerRow / 256);

    [rasterData appendBytes:bytes length:3 + bytesPerRow];
  }

  return rasterData;
}

@implementation RPImageRasterizer

#pragma mark - Public API

+ (NSData *)pixelsForDocument:(RPDocument *)document {
  return [self pixelsForImage:[document generateImage]];
}

+ (NSData *)pixelsForImage:(UIImage *)image {

  CGImageRef cgImage = image.CGImage;

  size_t width  = CGImageGetWidth(cgImage);
  size_t height = CGImageGetHeight(cgImage);

  RPPixel *pixels = malloc(width * height * sizeof(RPPixel));
  GenerateImagePixels(cgImage, pixels);

  return GetRasterDataForImage(cgImage, pixels);
}

@end
