//
//  KmeanEntryDataSet.h
//  VirtualCoach
//
//  Created by Bi ZORO on 04/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KmeanEntry.h"
#include <stdlib.h>
#include <stdio.h>

@interface KmeanEntryDataSet : NSObject <NSCoding>

@property (nonatomic) NSMutableArray * data;
@property (nonatomic) int datacount;

/*!
 @method addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speed1 andSecondSpeedVectorsTab:speed2 betweenInterval:interval andWithImageWidth:width
 @abstract
 Updates the value of the property time of object KmeanEntry and properties data and datacount of object KmeanEntryDataSet.
 KmeanEntryDataSet regroups all lines of KmeanEntry
 @param speed1
 Set of speed of pixel generated by the optical flow algorithm
 @param speed2
 Set of speed of pixel generated by the optical flow algorithm
 @param interval
 Interval of speed of pixel looked upon as interesting
 @param width
 Width of image using to generate speed of each pixel
 @discussion
 */

- (void)addKmeanEntryToDataSetFromFirstSpeedVectorsTab:(vect2darray_t *)speed1 andSecondSpeedVectorsTab:(vect2darray_t *)speed2 betweenInterval:(rect_t)interval andWithImageWidth:(uint16_t)width;

/*!
 @method writeHistogramAtPath:path
 @abstract
 Creates a file which stock the KmeanEntry for algorithm Kmean
 @param path
 Path used to write the file
 @discussion
 */
- (void)writeKmeanDatasetAtPath:(NSString *)path;

/*!
 @method loadHistogramAtPath:path
 @abstract
 Creates a KmeanEntryDataSet by loading data from file
 @param path
 Path used to write the file
 @discussion
 */
+ (id)loadKmeanDatasetAtPath:(NSString *)path;

- (void)writeKmeanDatasetForTestAtPath:(NSString *)path;

- (void)writeKmeanDataset3dForTestAtPath:(NSString *)path;

- (void)writeKmeanDataset4dForTestAtPath:(NSString *)path;

- (void)writeKmeanDataset2dSpeedTimeForTestAtPath:(NSString *)path;

@end
