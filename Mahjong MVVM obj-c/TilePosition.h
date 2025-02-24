//
//  TilePosition.h
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 22.02.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TilePosition : NSObject

@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) NSInteger layer; // Висота (3D)
//@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) BOOL isBlocked;

- (instancetype)initWithX:(CGFloat)x y:(CGFloat)y layer:(NSInteger)layer;

@end

NS_ASSUME_NONNULL_END
