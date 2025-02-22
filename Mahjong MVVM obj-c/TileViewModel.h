//
//  TileViewModel.h
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 21.02.2025.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TileModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TileViewModel : NSObject

@property (nonatomic, strong) TileModel *tileModel;

@property (nonatomic, strong) UIView *firstTile;
@property (nonatomic, strong) UIView *secondTile;

@property (nonatomic, assign) NSInteger firstTap;
@property (nonatomic, assign) NSInteger secondTap;


@property (nonatomic, assign) CGRect firstRectangle;
@property (nonatomic, assign) CGRect secondRectangle;

- (instancetype)initWithModel:(TileModel *)model;
- (UIView *)createTileViewWithNumber:(NSNumber *)number rect:(CGRect)rect
                               withX:(CGFloat)x withY:(CGFloat)y;
- (CGRect)calculateFrameForTile:(CGRect)frameView;
- (void)logicForRemovingTiles:(UIView *)tileView touchView:(UIView *)touchView;
- (void)resetGame;

@end

NS_ASSUME_NONNULL_END
