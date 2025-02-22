//
//  TileModel.h
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 21.02.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TileModel : NSObject

@property (nonatomic, strong) NSMutableArray<NSNumber *> *randomNumbers;
//@property (nonatomic, assign) int staticNumber;
@property (nonatomic, assign) CGFloat widthBorder;

- (instancetype)init;
- (void)generateRandomNumbers;
- (BOOL)isTileMatchFirstTile:(NSInteger)firstTap secondTile:(NSInteger)secondTap;
- (void)resetGame;

@end

NS_ASSUME_NONNULL_END
