//
//  ViewController.m
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 21.02.2025.
//
#import "ViewController.h"
#import "TileModel.h"
#import "TileViewModel.h"
#import "TileLayout.h"

//static CGFloat widthBorder = 30;
static CGRect rectTile;

@interface ViewController () <TileViewModelDelegate>

@property (nonatomic, strong) TileViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray <UIView *> *tiles;

- (IBAction)testButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupTiles];
    rectTile = CGRectMake(0, 0, 92.5, 174.4);
    TileModel *model = [[TileModel alloc] init];
    self.viewModel = [[TileViewModel alloc] initWithModel:model];
    self.tiles = [NSMutableArray new];
    self.viewModel.delegate = self;
    [self.viewModel.tileModel generateRandomNumbers];
    [self addTilesToScene];
}

- (void)addTilesToScene {
//    CGRect rectView = [self.viewModel calculateFrameForTile:self.view.frame];
//    CGRect rectView = CGRectMake(0, 0, 92.5, 174.4);
//    CGFloat x = 0.0;
//    CGFloat y = 0.0;
    
    NSArray<TilePosition *> *tilePositions = [self.viewModel generateMahjongLayout];
    
    for (int i = 0; i < self.viewModel.tileModel.randomNumbers.count; i++) {
//        if ((i % 4) == 0) { x = rectView.origin.x; }
//        else { x = x + rectView.size.width; }
//        if (i < 4) { y = rectView.origin.y; }
//        else if ((i % 4) == 0) { y = y + rectView.size.height; }

//        UIView *tileView = [self.viewModel createTileViewWithNumber:[self.viewModel.tileModel.randomNumbers objectAtIndex:i]
//                                                               rect:rectView
//                                                              withX:x withY:y];
        
        TilePosition *tilePosition = [tilePositions objectAtIndex:i];
        
        UIView *tileView = [self.viewModel createTileViewWithNumber:[self.viewModel.tileModel.randomNumbers objectAtIndex:i]
                                                               rect:rectTile
                                                              withX:tilePosition.x
                                                              withY:tilePosition.y];
        
        [self configTileView:tileView];
        [self.tiles addObject:tileView];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureTap:)];
        [tileView addGestureRecognizer:tapGestureRecognizer];
        [self.view addSubview:tileView];
    }
}

- (void)tapGestureTap:(UITapGestureRecognizer *)gestureTap {
    UIView *tileView = gestureTap.view;
    tileView.backgroundColor = [UIColor grayColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        tileView.backgroundColor = [UIColor systemIndigoColor];
            });
    
    TileData *tileData = [[TileData alloc] initWithTag:tileView.tag frame:tileView.frame];
    [self.viewModel logicForRemovingTiles:tileData];
}

- (void)configTileView:(UIView *)tileView
{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:tileView.bounds];
    tileView.backgroundColor = [UIColor systemIndigoColor];
    tileView.layer.cornerRadius = 20;
    tileView.layer.shadowColor = [UIColor blackColor].CGColor;
    tileView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    tileView.layer.shadowOpacity = 0.5f;
    tileView.layer.shadowPath = shadowPath.CGPath;
    tileView.layer.borderColor = [UIColor whiteColor].CGColor;
    tileView.layer.borderWidth = 2;
    tileView.layer.masksToBounds = NO;
}

#pragma mark - delegate

- (void)didSelectTileAtPosition:(NSInteger)firstTag secongData:(NSInteger)secondTag
{    
    NSMutableArray *tilesToRemove = [NSMutableArray array];
    
    for (UIView *tile in self.tiles) {
        if (tile.tag == firstTag || tile.tag == secondTag) {
            [tilesToRemove addObject:tile];
        }
    }
    
    for (UIView *tile in tilesToRemove) {
        [tile removeFromSuperview];
        [self.tiles removeObject:tile];
    }
}

#pragma mark - action

- (IBAction)testButton:(id)sender {
    [self.viewModel resetGame];
    [self addTilesToScene];
}

@end
