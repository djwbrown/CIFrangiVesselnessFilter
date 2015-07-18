//
//  Frangi_VesselnessFilter.m
//  Frangi Vesselness
//
//  Created by Dylan Walker Brown on 7/18/15.
//  Copyright © 2015 Dylan Walker Brown. All rights reserved.
//

#import "Frangi_VesselnessFilter.h"
#import <Foundation/Foundation.h>
#import <ApplicationServices/ApplicationServices.h>

@implementation Frangi_VesselnessFilter

static CIKernel *_Hessian_xx_Kernel = nil;
static CIKernel *_Hessian_xy_Kernel = nil;
static CIKernel *_Hessian_yy_Kernel = nil;

- (instancetype)init
{
    if(!_Hessian_xx_Kernel) {
		NSBundle    *bundle = [NSBundle bundleForClass:NSClassFromString(@"Frangi_VesselnessFilter")];
		NSStringEncoding encoding = NSUTF8StringEncoding;
		NSError     *error = nil;
		NSString    *code = [NSString stringWithContentsOfFile:[bundle pathForResource:@"Hessian_xx_Kernel" ofType:@"cikernel"] encoding:encoding error:&error];
		NSArray     *kernels = [CIKernel kernelsWithString:code];

		_Hessian_xx_Kernel = kernels[0];
    }
    if(!_Hessian_xy_Kernel) {
        NSBundle    *bundle = [NSBundle bundleForClass:NSClassFromString(@"Frangi_VesselnessFilter")];
        NSStringEncoding encoding = NSUTF8StringEncoding;
        NSError     *error = nil;
        NSString    *code = [NSString stringWithContentsOfFile:[bundle pathForResource:@"Hessian_xy_Kernel" ofType:@"cikernel"] encoding:encoding error:&error];
        NSArray     *kernels = [CIKernel kernelsWithString:code];
        
        _Hessian_xy_Kernel = kernels[0];
    }
    if(!_Hessian_yy_Kernel) {
        NSBundle    *bundle = [NSBundle bundleForClass:NSClassFromString(@"Frangi_VesselnessFilter")];
        NSStringEncoding encoding = NSUTF8StringEncoding;
        NSError     *error = nil;
        NSString    *code = [NSString stringWithContentsOfFile:[bundle pathForResource:@"Hessian_yy_Kernel" ofType:@"cikernel"] encoding:encoding error:&error];
        NSArray     *kernels = [CIKernel kernelsWithString:code];
        
        _Hessian_yy_Kernel = kernels[0];
    }
    return [super init];
}

- (CGRect)regionOf:(int)sampler  destRect:(CGRect)rect  userInfo:(NSNumber *)radius
{
    return CGRectInset(rect, 0, 0);
}

- (NSDictionary *)customAttributes
{
    return @{
        @"inputCenter":@{
            kCIAttributeDefault:[CIVector vectorWithX:200.0 Y:200.0],
            kCIAttributeType:kCIAttributeTypePosition,
        },
        @"inputWidth":@{
            kCIAttributeMin:@1.00,
            kCIAttributeSliderMin:@1.00,
            kCIAttributeSliderMax:@1000.00,
            kCIAttributeDefault:@400.00,
            kCIAttributeIdentity:@400.00,
            kCIAttributeType:kCIAttributeTypeDistance,
        },
        @"inputAmount":@{
            kCIAttributeMin:@0.00,
            kCIAttributeSliderMin:@0.00,
            kCIAttributeSliderMax:@2.00,
            kCIAttributeDefault:@0.50,
            kCIAttributeIdentity:@0.00,
            kCIAttributeType:kCIAttributeTypeDistance,
        },
    };
}

// called when setting up for fragment program and also calls fragment program
- (CIImage *)outputImage
{
    CISampler *src;
    CIImage *result;
    
    src = [CISampler samplerWithImage:inputImage];
    result = [self apply:_Hessian_xx_Kernel, src, nil];
    src = [CISampler samplerWithImage:result];
    result = [self apply:_Hessian_xy_Kernel, src, nil];
    src = [CISampler samplerWithImage:result];
    result = [self apply:_Hessian_yy_Kernel, src, nil];
    return result;
}

@end
