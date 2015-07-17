//
//  CIFrangiVesselnessFilterFilter.h
//  CIFrangiVesselnessFilter
//
//  Created by Dylan Walker Brown on 7/17/15.
//  Copyright © 2015 Dylan Walker Brown. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CIFrangiVesselnessFilterFilter : CIFilter {
    CIImage      *inputImage;
    CIVector     *inputCenter;
    NSNumber     *inputWidth;
    NSNumber     *inputAmount;
}

@end
