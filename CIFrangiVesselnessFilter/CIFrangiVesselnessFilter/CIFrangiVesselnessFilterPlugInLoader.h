//
//  CIFrangiVesselnessFilterPlugInLoader.h
//  CIFrangiVesselnessFilter
//
//  Created by Dylan Walker Brown on 7/17/15.
//  Copyright © 2015 Dylan Walker Brown. All rights reserved.
//

#import <QuartzCore/CoreImage.h>

@interface CIFrangiVesselnessFilterPlugInLoader : NSObject <CIPlugInRegistration>

- (BOOL)load:(void *)host;

@end
