//
//  TilePosition.m
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 22.02.2025.
//

#import "TilePosition.h"

@implementation TilePosition

- (instancetype)initWithX:(CGFloat)x y:(CGFloat)y layer:(NSInteger)layer {
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
        _layer = layer;
        _blocked = NO;
    }
    return self;
}

@end
