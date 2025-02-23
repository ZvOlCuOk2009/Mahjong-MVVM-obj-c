//
//  TileData.h
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 23.02.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TileData : NSObject

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) CGRect frame;

- (instancetype)initWithTag:(NSInteger)tag frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
