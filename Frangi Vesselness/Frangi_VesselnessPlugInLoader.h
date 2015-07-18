//
//  Frangi_VesselnessPlugInLoader.h
//  Frangi Vesselness
//
//  Created by Dylan Walker Brown on 7/18/15.
//  Copyright © 2015 Dylan Walker Brown. All rights reserved.
//

#import <QuartzCore/CoreImage.h>

@interface Frangi_VesselnessPlugInLoader : NSObject <CIPlugInRegistration>

- (BOOL)load:(void *)host;

@end
