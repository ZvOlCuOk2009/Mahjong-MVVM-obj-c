//
//  TileViewModel.m
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 21.02.2025.
//

#import "TileViewModel.h"

static CGFloat widthBorder = 30;

@implementation TileViewModel

//- (instancetype)initWithLayout:(NSArray<TilePosition *> *)layout {
//    self = [super init];
//    if (self) {
//        _tiles = layout;
//    }
//    return self;
//}

- (instancetype)initWithModel:(TileModel *)model {
    self = [super init];
    if (self) {
        _tileModel = model;
        _firstTap = -1;
        _secondTap = -1;
        _firstRectangle = CGRectZero;
        _secondRectangle = CGRectZero;
    }
    return self;
}

- (UIView *)createTileViewWithNumber:(NSNumber *)number rect:(CGRect)rect
                               withX:(CGFloat)x withY:(CGFloat)y
{
    UIView *tileView = [[UIView alloc] init];
    tileView.frame = CGRectMake(x, y, rect.size.width, rect.size.height);
    tileView.tag = [number integerValue];

    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, (rect.size.height / 2) / 2, rect.size.width, rect.size.height / 2);
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:60];
    label.textAlignment = 1;
    [tileView addSubview:label];
    label.text = [number stringValue];;
    return tileView;
}

//- (BOOL)isTileAccessible:(TilePosition *)tile {
//    for (TilePosition *other in self.tiles) {
//        if (other.layer > tile.layer && other.x == tile.x && other.y == tile.y) {
//            return NO; // Є плитка зверху
//        }
//        if (other.x == tile.x - 1 || other.x == tile.x + 1) {
//            return YES; // Має хоча б одну вільну сторону
//        }
//    }
//    return NO;
//}

- (void)logicForRemovingTiles:(TileData *)tileData
{
    CGRect zeroRect = CGRectMake(0, 0, 0, 0);
    if (CGRectEqualToRect(self.firstRectangle, zeroRect)) {
        self.firstRectangle = tileData.frame;
    } else if (CGRectEqualToRect(self.firstRectangle, tileData.frame)) {
        self.firstRectangle = tileData.frame;
        return;
    } else {
        self.firstRectangle = tileData.frame;
    }

    NSString *tag = [NSString stringWithFormat:@"%li", tileData.tag];

    if (self.firstTile == nil && self.secondTile == nil) {
        self.firstTap = [tag integerValue];
        self.firstTile = tileData;
    } else if (self.firstTile != nil && self.firstTap != [tag integerValue]) {
        self.firstTap = [tag integerValue];
        self.firstTile = tileData;
    } else if (self.firstTile != nil && self.firstTap == [tag integerValue]) {
        self.secondTap = [tag integerValue];
        self.secondTile = tileData;
    }

    if (self.firstTap == self.secondTap) {
        [self.delegate didSelectTileAtPosition:self.firstTap secongData:self.secondTap];
        self.firstRectangle = CGRectMake(0, 0, 0, 0);
        [self resetTaps];
    } else if (self.secondTile != nil) {
        self.firstTap = [tag integerValue];
        self.secondTap = 0;
    }
}

- (void)resetTaps
{
    self.firstTap = 10000;
    self.secondTap = 10000;
}

- (void)resetGame {
    [self.tileModel resetGame];
    self.firstTap = -1;
    self.secondTap = -1;
}

#pragma mark - tile placement calculation

- (CGRect)calculateFrameForTile:(CGRect)frameView
{
    return CGRectMake(widthBorder, widthBorder, [self calculateWidthForFrame:frameView], [self calculateHeightForFrame:frameView]);
}

- (CGFloat)calculateWidthForFrame:(CGRect)frameView
{
    return (frameView.size.width - [self retreatFromFrame]) / 4;
}

- (CGFloat)calculateHeightForFrame:(CGRect)frameView
{
    return (frameView.size.height - [self retreatFromFrame]) / 5;
}

- (CGFloat)retreatFromFrame
{
    return widthBorder * 2;
}

@end
