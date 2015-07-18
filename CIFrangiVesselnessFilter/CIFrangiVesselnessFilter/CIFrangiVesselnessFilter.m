//
//  CIFrangiVesselnessFilter.m
//  CIFrangiVesselnessFilter
//
//  Created by Dylan Walker Brown on 7/17/15.
//  Copyright © 2015 Dylan Walker Brown. All rights reserved.
//

#import "CIFrangiVesselnessFilter.h"
#import <Foundation/Foundation.h>
#import <ApplicationServices/ApplicationServices.h>

@implementation CIFrangiVesselnessFilter

static CIKernel *_Hessian_xx_Kernel = nil;
static CIKernel *_Hessian_xy_Kernel = nil;
static CIKernel *_Hessian_yy_Kernel = nil;


- (instancetype)init
{
    if(!_Hessian_xx_Kernel) {
		NSBundle    *bundle = [NSBundle bundleForClass:NSClassFromString(@"CIFrangiVesselnessFilter")];
		NSStringEncoding encoding = NSUTF8StringEncoding;
		NSError     *error = nil;
		NSString    *code1 = [NSString stringWithContentsOfFile:[bundle pathForResource:@"Hessian_xx_Kernel" ofType:@"cikernel"]
                                                      encoding:encoding
                                                         error:&error];
        NSString    *code2 = [NSString stringWithContentsOfFile:[bundle pathForResource:@"Hessian_xy_Kernel" ofType:@"cikernel"]
                                                       encoding:encoding
                                                          error:&error];
        NSString    *code3 = [NSString stringWithContentsOfFile:[bundle pathForResource:@"Hessian_yy_Kernel" ofType:@"cikernel"]
                                                       encoding:encoding
                                                          error:&error];
        
        NSArray     *kernels = [NSArray arrayWithObjects:
                                [CIKernel kernelsWithString:code1],
                                [CIKernel kernelsWithString:code2],
                                [CIKernel kernelsWithString:code3], nil];

		_Hessian_xx_Kernel = kernels[0];
        _Hessian_xy_Kernel = kernels[1];
        _Hessian_yy_Kernel = kernels[2];
        
    }
    return [super init];
}

- (CGRect)regionOf:(int)sampler  destRect:(CGRect)rect  userInfo:(NSNumber *)sigma
{
    return CGRectInset(rect, -[sigma floatValue], -[sigma floatValue]);
}

- (NSDictionary *)customAttributes
{
    return @{
        @"inputSigma":@{
            kCIAttributeMin:@1.00,
            kCIAttributeSliderMin:@1.00,
            kCIAttributeSliderMax:@10.00,
            kCIAttributeDefault:@2.00,
            kCIAttributeType:kCIAttributeTypeScalar,
        },
    };
}

// called when setting up for fragment program and also calls fragment program
- (CIImage *)outputImage
{
    float sigma;
    CISampler *src;
    
    src = [CISampler samplerWithImage:inputImage];
    sigma = [inputSigma floatValue];
    return [self apply:_Hessian_xx_Kernel, src, nil];
    
//    [self apply:_Hessian_xy_Kernel, src, nil];
//    return [self apply:_Hessian_xy_Kernel, src, nil];
    
//    return [self apply:_CIFrangiVesselnessFilterKernel, src,
//        [NSNumber numberWithFloat:sigma],
//	    kCIApplyOptionDefinition, [[src definition] insetByX:-sigma * 3.0 Y:-sigma * 3.0],
//	    kCIApplyOptionUserInfo, [NSNumber numberWithFloat:sigma * 3.0], nil];
}

@end
