//
//  CIFrangiVesselnessFilter.h
//  CIFrangiVesselnessFilter
//
//  Created by Dylan Walker Brown on 7/17/15.
//  Copyright © 2015 Dylan Walker Brown. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CIFrangiVesselnessFilter : CIFilter {
    CIImage      *inputImage;
    NSNumber     *inputSigma;
}

@end
