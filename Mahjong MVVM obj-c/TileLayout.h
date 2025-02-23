//
//  TileLayout.h
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 22.02.2025.
//

#import <Foundation/Foundation.h>
#import "TilePosition.h"

NS_ASSUME_NONNULL_BEGIN

@interface TileLayout : NSObject

- (NSArray<TilePosition *> *)generateCircleLayout;
//+ (NSArray<TilePosition *> *)generatePyramidLayout;
//+ (NSArray<TilePosition *> *)generateTowerLayout;

@end

NS_ASSUME_NONNULL_END
