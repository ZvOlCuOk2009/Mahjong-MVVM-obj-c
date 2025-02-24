//
//  TileModel.m
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 21.02.2025.
//

#import "TileModel.h"

static int staticNumber = 10;

@implementation TileModel

NSMutableArray<NSNumber *> *_subNumbers;

- (instancetype)init {
    self = [super init];
    if (self) {
        _randomNumbers = [NSMutableArray new];
        _subNumbers = [NSMutableArray new];
//        _widthBorder = 30;
    }
    return self;
}

- (void)generateRandomNumbers {
    for (int i = 0; i < staticNumber; i++) {
        NSNumber *number = [NSNumber numberWithInteger:(arc4random_uniform(staticNumber))];
        if ([self.randomNumbers containsObject:number]) {
            i--;
            if ([_subNumbers containsObject:number]) {
                i--;
            } else {
                [_subNumbers addObject:number];
            }
        } else {
            [self.randomNumbers addObject:number];
        }
        if ([self.randomNumbers count] == staticNumber && [_subNumbers count] == staticNumber) {
            [self.randomNumbers addObjectsFromArray:_subNumbers];
            return;
        }
    }
}

- (void)resetGame {
    [self.randomNumbers removeAllObjects];
    [_subNumbers removeAllObjects];
    [self generateRandomNumbers];
}

@end
