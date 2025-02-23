//
//  TileLayout.m
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 22.02.2025.
//

#import "TileLayout.h"

@implementation TileLayout

+ (NSArray<TilePosition *> *)generatePyramidLayout {
    return [self generateLayoutWithBaseX:2 baseY:0 layers:3];
}

+ (NSArray<TilePosition *> *)generateTowerLayout {
    return [self generateLayoutWithBaseX:2 baseY:0 layers:2];
}

+ (NSArray<TilePosition *> *)generateLayoutWithBaseX:(NSInteger)x baseY:(NSInteger)y layers:(NSInteger)layers {
    NSMutableArray<TilePosition *> *positions = [NSMutableArray array];
    for (NSInteger layer = 0; layer < layers; layer++) {
        for (NSInteger i = -layer; i <= layer; i++) {
            [positions addObject:[[TilePosition alloc] initWithX:(x + i) y:(y + layer) layer:layer]];
        }
    }
    return positions;
}

- (NSArray<TilePosition *> *)generateCircleLayout
{
    return @[
        [[TilePosition alloc] initWithX:122.5 y:30 layer:0],
        [[TilePosition alloc] initWithX:215 y:30 layer:0],
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
        [[TilePosition alloc] initWithX:122.5 y:727.6 layer:0],
        [[TilePosition alloc] initWithX:215 y:727.6 layer:0],
    ];
}

//+ (NSArray<TilePosition *> *)generatePyramidLayout {
//    return @[
//        [[TilePosition alloc] initWithX:2 y:0 layer:0],
//        [[TilePosition alloc] initWithX:1 y:1 layer:0],
//        [[TilePosition alloc] initWithX:3 y:1 layer:0],
//        [[TilePosition alloc] initWithX:0 y:2 layer:0],
//        [[TilePosition alloc] initWithX:4 y:2 layer:0],
//        [[TilePosition alloc] initWithX:2 y:1 layer:1],
//    ];
//}
//
//+ (NSArray<TilePosition *> *)generateTowerLayout {
//    return @[
//        [[TilePosition alloc] initWithX:2 y:0 layer:0],
//        [[TilePosition alloc] initWithX:2 y:1 layer:0],
//        [[TilePosition alloc] initWithX:2 y:2 layer:0],
//        [[TilePosition alloc] initWithX:2 y:3 layer:0],
//        [[TilePosition alloc] initWithX:2 y:4 layer:0],
//        [[TilePosition alloc] initWithX:2 y:2 layer:1],
//    ];
//}

@end
