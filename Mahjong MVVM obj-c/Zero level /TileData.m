//
//  TileData.m
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 23.02.2025.
//

#import "TileData.h"

@implementation TileData

- (instancetype)initWithTag:(NSInteger)tag frame:(CGRect)frame {
    self = [super init];
    if (self) {
        _tag = tag;
        _frame = frame;
    }
    return self;
}

@end
