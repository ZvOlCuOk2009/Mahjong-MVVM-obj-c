//
//  TileViewModel.h
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 21.02.2025.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TileModel.h"
#import "TilePosition.h"
#import "TileData.h"
#import "TileLayout.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TileViewModelDelegate <NSObject>

- (void)didSelectTileAtPosition:(NSInteger)firstTag secongData:(NSInteger)secondTag;

@end

@interface TileViewModel : NSObject

@property (nonatomic, strong) TileModel *tileModel;
@property (nonatomic, strong) TileLayout *tileModeLayout;

@property (nonatomic, weak) id<TileViewModelDelegate> delegate;

//@property (nonatomic, strong) UIView *firstTile;
//@property (nonatomic, strong) UIView *secondTile;

@property (nonatomic, strong) TileData *firstTile;
@property (nonatomic, strong) TileData *secondTile;

@property (nonatomic, assign) NSInteger firstTap;
@property (nonatomic, assign) NSInteger secondTap;

@property (nonatomic, assign) CGRect firstRectangle;
@property (nonatomic, assign) CGRect secondRectangle;

@property (nonatomic, strong) NSArray<TilePosition *> *tiles;

- (void)logicForRemovingTiles:(TileData *)tileData;

//- (instancetype)initWithLayout:(NSArray<TilePosition *> *)layout;
//- (BOOL)isTileAccessible:(TilePosition *)tile;
- (instancetype)initWithModel:(TileModel *)model;
//- (instancetype)initWithModel:(TileLayout *)modelLayout;
- (NSArray<TilePosition *> *)generateCircleLayout;
- (NSArray<TilePosition *> *)generateFanLayout;
- (NSArray<TilePosition *> *)generateMahjongLayout;
- (UIView *)createTileViewWithNumber:(NSNumber *)number rect:(CGRect)rect
                               withX:(CGFloat)x withY:(CGFloat)y;
- (CGRect)calculateFrameForTile:(CGRect)frameView;
- (void)resetGame;

@end

NS_ASSUME_NONNULL_END
