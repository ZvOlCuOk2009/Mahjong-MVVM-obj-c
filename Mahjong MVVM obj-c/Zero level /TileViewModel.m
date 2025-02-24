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

- (NSArray<TilePosition *> *)generateCircleLayout {
    NSMutableArray<TilePosition *> *positions = [NSMutableArray array];
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat width = CGRectGetWidth(screenBounds);
    CGFloat height = CGRectGetHeight(screenBounds);
    CGFloat padding = 30.0;
    CGFloat tileSize = 92.0; // Припустимо, що розмір плитки 85 пікселів
    
    CGFloat centerX = width / 2;
    CGFloat centerY = height / 2;
    CGFloat radius = MIN(width, height) / 3; // Радіус кола
    
    NSInteger numberOfTiles = 16;
    for (NSInteger i = 0; i < numberOfTiles; i++) {
        CGFloat angle = (2 * M_PI / numberOfTiles) * i;
        CGFloat x = centerX + radius * cos(angle) - tileSize / 2;
        CGFloat y = centerY + radius * sin(angle) - tileSize / 2;
        
        if (x < padding) x = padding;
        if (y < padding) y = padding;
        if (x + tileSize > width - padding) x = width - tileSize - padding;
        if (y + tileSize > height - padding) y = height - tileSize - padding;
        
        TilePosition *tile = [[TilePosition alloc] initWithX:x y:y layer:0];
        [positions addObject:tile];
    }
    return positions;
}

- (NSArray<TilePosition *> *)generateMahjongLayout {
    NSMutableArray<TilePosition *> *positions = [NSMutableArray array];
        
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat width = CGRectGetWidth(screenBounds);
    CGFloat height = CGRectGetHeight(screenBounds);
    CGFloat padding = 30.0;
    CGFloat tileSize = 85.0;
        
    CGFloat centerX = width / 2;
    CGFloat centerY = height / 2;
        
    NSArray<NSArray<NSNumber *> *> *layout = @[
    @[@(0), @(1), @(1), @(1), @(0)],
    @[@(1), @(2), @(2), @(2), @(1)],
    @[@(1), @(2), @(3), @(2), @(1)],
    @[@(1), @(2), @(2), @(2), @(1)],
    @[@(0), @(1), @(1), @(1), @(0)]];

    CGFloat startX = centerX - (tileSize * 2) - padding;
    CGFloat startY = centerY - (tileSize * 2) - padding;
        
    for (NSInteger row = 0; row < layout.count; row++) {
        for (NSInteger col = 0; col < layout[row].count; col++) {
            NSInteger layer = [layout[row][col] integerValue];
            if (layer > 0) {
                CGFloat x = startX + col * tileSize;
                CGFloat y = startY + row * tileSize;
                
                BOOL isBlocked = [self isTileBlockedAtRow:row col:col layout:layout];
                TilePosition *tile = [[TilePosition alloc] initWithX:x y:y layer:layer - 1];
                            tile.isBlocked = isBlocked; // Додаємо властивість `isBlocked`
                [positions addObject:tile];
            }
        }
    }
    return positions;
}

- (BOOL)isTileBlockedAtRow:(NSInteger)row col:(NSInteger)col
                    layout:(NSArray<NSArray<NSNumber *> *> *)layout {
    NSInteger rowCount = layout.count;
    NSInteger colCount = layout.firstObject.count;

    // Перевіряємо чи є сусіди зліва, справа та зверху
    BOOL hasLeft = (col > 0) && ([layout[row][col - 1] integerValue] > 0);
    BOOL hasRight = (col < colCount - 1) && ([layout[row][col + 1] integerValue] > 0);
    BOOL hasTop = (row > 0) && ([layout[row - 1][col] integerValue] > 0);
    BOOL hasBottom = (row < rowCount - 1) && ([layout[row + 1][col] integerValue] > 0);
    return hasLeft && hasRight && hasTop && hasBottom;
}

//- (NSArray<TilePosition *> *)generateCircleLayout
//{
//    return @[
//        [[TilePosition alloc] initWithX:122.5 y:30 layer:0],
//        [[TilePosition alloc] initWithX:215 y:30 layer:0],
//        [[TilePosition alloc] initWithX:30 y:204.4 layer:0],
//        [[TilePosition alloc] initWithX:122.5 y:204.4 layer:0],
//        [[TilePosition alloc] initWithX:215 y:204.4 layer:0],
//        [[TilePosition alloc] initWithX:307.5 y:204.4 layer:0],
//        [[TilePosition alloc] initWithX:30 y:378.8 layer:0],
//        [[TilePosition alloc] initWithX:122.5 y:378.8 layer:0],
//        [[TilePosition alloc] initWithX:215 y:378.8 layer:0],
//        [[TilePosition alloc] initWithX:307.5 y:378.8 layer:0],
//        [[TilePosition alloc] initWithX:30 y:553.2 layer:0],
//        [[TilePosition alloc] initWithX:122.5 y:553.2 layer:0],
//        [[TilePosition alloc] initWithX:215 y:553.2 layer:0],
//        [[TilePosition alloc] initWithX:307.5 y:553.2 layer:0],
//        [[TilePosition alloc] initWithX:122.5 y:727.6 layer:0],
//        [[TilePosition alloc] initWithX:215 y:727.6 layer:0],
//    ];
//}

- (NSArray<TilePosition *> *)generateFanLayout
{
    return @[
        [[TilePosition alloc] initWithX:30 y:30 layer:0],
        [[TilePosition alloc] initWithX:307.5 y:30 layer:0],
        [[TilePosition alloc] initWithX:30 y:204.4 layer:0],
        [[TilePosition alloc] initWithX:122.5 y:204.4 layer:0],
        [[TilePosition alloc] initWithX:215 y:204.4 layer:0],
        [[TilePosition alloc] initWithX:307.5 y:204.4 layer:0],
        [[TilePosition alloc] initWithX:30 y:378.8 layer:0],
        [[TilePosition alloc] initWithX:122.5 y:378.8 layer:0],
        [[TilePosition alloc] initWithX:215 y:378.8 layer:0],
        [[TilePosition alloc] initWithX:307.5 y:378.8 layer:0],
        [[TilePosition alloc] initWithX:30 y:553.2 layer:0],
        [[TilePosition alloc] initWithX:122.5 y:553.2 layer:0],
        [[TilePosition alloc] initWithX:215 y:553.2 layer:0],
        [[TilePosition alloc] initWithX:307.5 y:553.2 layer:0],
        [[TilePosition alloc] initWithX:30 y:727.6 layer:0],
        [[TilePosition alloc] initWithX:307.5 y:727.6 layer:0],
    ];
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
