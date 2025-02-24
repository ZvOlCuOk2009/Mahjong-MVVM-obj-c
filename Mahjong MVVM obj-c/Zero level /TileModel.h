//
//  TileModel.h
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 21.02.2025.
//

#import <Foundation/Foundation.h>
#import "TilePosition.h"

NS_ASSUME_NONNULL_BEGIN

@interface TileModel : NSObject

@property (nonatomic, strong) NSMutableArray<NSNumber *> *randomNumbers;
//@property (nonatomic, assign) CGFloat widthBorder;

- (instancetype)init;
- (void)generateRandomNumbers;
- (void)resetGame;

@end

NS_ASSUME_NONNULL_END
