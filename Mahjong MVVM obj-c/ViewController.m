//
//  ViewController.m
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 21.02.2025.
//
#import "ViewController.h"
#import "TileModel.h"
#import "TileViewModel.h"

//static CGFloat widthBorder = 30;

@interface ViewController ()

@property (nonatomic, strong) TileViewModel *viewModel;
@property (strong, nonatomic) UIView *touchView;

- (IBAction)testButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TileModel *model = [[TileModel alloc] init];
    self.viewModel = [[TileViewModel alloc] initWithModel:model];
    
    [self.viewModel.tileModel generateRandomNumbers];
    [self addTilesToScene];
}

- (void)addTilesToScene {
    CGRect rectView = [self.viewModel calculateFrameForTile:self.view.frame];
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    
    for (int i = 0; i < self.viewModel.tileModel.randomNumbers.count; i++) {
        if ((i % 4) == 0) { x = rectView.origin.x; }
        else { x = x + rectView.size.width; }
        if (i < 4) { y = rectView.origin.y; }
        else if ((i % 4) == 0) { y = y + rectView.size.height; }

        UIView *tileView = [self.viewModel createTileViewWithNumber:[self.viewModel.tileModel.randomNumbers objectAtIndex:i]
                                                               rect:rectView
                                                              withX:x withY:y];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureTap:)];
        [tileView addGestureRecognizer:tapGestureRecognizer];
        [self.view addSubview:tileView];
    }
}

- (void)tapGestureTap:(UITapGestureRecognizer *)gestureTap {
    UIView *tileView = gestureTap.view;
    self.touchView = tileView;
    tileView.backgroundColor = [UIColor grayColor];
    [self performSelector:@selector(returnColor)
               withObject:nil
               afterDelay:0.1];
    [self.viewModel logicForRemovingTiles:tileView touchView:self.touchView];
}

- (void)returnColor {
    self.touchView.backgroundColor = [UIColor systemIndigoColor];
}

- (IBAction)testButton:(id)sender {
    [self.viewModel resetGame];
    [self addTilesToScene];
}

@end
