//
//  ThreeMusicsCell.m
//  Enesco
//
//  Created by wangjie on 16/6/5.
//  Copyright © 2016年 aufree. All rights reserved.
//
#define UIScreenWidth [UIScreen mainScreen ].bounds.size.width
#define UIScreenHeight [UIScreen mainScreen ].bounds.size.height

#import "ThreeMusicsCell.h"
#import "LessionInfoView.h"

@interface ThreeMusicsCell()
@property (nonatomic, strong) LessionInfoView * lession1;
@property (nonatomic, strong) LessionInfoView * lession2;
@property (nonatomic, strong) LessionInfoView * lession3;
@property (nonatomic, assign) BOOL isCache;
@property (nonatomic, strong) UIImageView * lockImage;
@end

@implementation ThreeMusicsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setUpUI];
    }
    
    return self;
}

-(void)setUpUI{
    float l1x = (UIScreenWidth - 150) / 2;
    float l1y = 0;
    float lWidth = 150;
    float lHeight = 190;
    
    _lession1 = [[LessionInfoView alloc] initWithFrame:CGRectMake(l1x, l1y, lWidth, lHeight)];
    
    _lession1.cover.image = [UIImage imageNamed:@"percent_QA"];
    
    [self addSubview:_lession1];
    
    UITapGestureRecognizer *singleRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    singleRecognizer1.numberOfTapsRequired = 1;
    [_lession1 addGestureRecognizer:singleRecognizer1];
    
    float l23y = 200;
    
    float l2x =  (UIScreenWidth - 150 * 2) / 3;
    
    _lession2 = [[LessionInfoView alloc] initWithFrame:CGRectMake(l2x, l23y, lWidth, lHeight)];
    
    _lession2.cover.image = [UIImage imageNamed:@"percent_sport"];
    
    [self addSubview:_lession2];
    
    UITapGestureRecognizer *singleRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    singleRecognizer2.numberOfTapsRequired = 1;
    [_lession2 addGestureRecognizer:singleRecognizer2];
    
    float l3x = l2x * 2 + 150;
    
    _lession3 = [[LessionInfoView alloc] initWithFrame:CGRectMake(l3x, l23y, lWidth, lHeight)];
    
    _lession3.cover.image = [UIImage imageNamed:@"percent_sport"];
    
    [self addSubview:_lession3];
    
    UITapGestureRecognizer *singleRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    singleRecognizer3.numberOfTapsRequired = 1;
    [_lession3 addGestureRecognizer:singleRecognizer3];
    
    [self setUpLockImage];
}

- (void)setSection:(SectionClass *)section {
    _section = section;
    self.isCache = YES;
    RecordClass *record = (RecordClass *)[section.records objectAtIndex:0];
    if(!record.music){
        record.music = [[MusicEntity alloc] init];
        record.music.name = record.title;
        record.music.artistName = @"Bubiji";
    }
    if(!record.music.musicId){
        self.isCache = NO;
    }
    _lession1.musicEntity = record.music;
    _lession1.record = record;
    _lession1.musicNumber = 1;
    
    record = (RecordClass *)[section.records objectAtIndex:1];
    if(!record.music){
        record.music = [[MusicEntity alloc] init];
        record.music.name = record.title;
        record.music.artistName = @"Bubiji";
    }
    if(!record.music.musicId){
        self.isCache = NO;
    }
    _lession2.musicEntity = record.music;
    _lession2.record = record;
    _lession2.musicNumber = 2;
    
     record = (RecordClass *)[section.records objectAtIndex:2];
    if(!record.music){
        record.music = [[MusicEntity alloc] init];
        record.music.name = record.title;
        record.music.artistName = @"Bubiji";
    }
    if(!record.music.musicId){
        self.isCache = NO;

    }
    _lession3.musicEntity = record.music;
    _lession3.record = record;
    _lession3.musicNumber = 3;
    
    if(self.isCache){
        self.lockImage.hidden = YES;
    }
    else{
        self.lockImage.hidden = NO;
    }
    
}

-(void)setUpLockImage{
    self.lockImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 400)];
    self.lockImage.image = [UIImage imageNamed:@"lock.jpg"];
    [self addSubview:self.lockImage];
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    if(!self.isCache){
        return;
    }
    UIView *tmp = recognizer.view;
    NSInteger index = 0;
    if(tmp == _lession1){
        index = 0;
    }
    else if(tmp == _lession2){
        index = 1;
    }
    else if(tmp == _lession3){
        index =2;
    }
    if(self.delegate){
        [self.delegate jumpTo:self.section index:index];
    }
}

-(void)change:(RecordClass *)record to:(NAKPlaybackIndicatorViewState)state{
    RecordClass * rc = [self.section.records objectAtIndex:0];
    
    _lession1.state = NAKPlaybackIndicatorViewStateStopped;
    if([record.title isEqualToString:rc.title]){
        _lession1.state = NAKPlaybackIndicatorViewStatePlaying;
    }
    
    rc = [self.section.records objectAtIndex:1];
    
    _lession2.state = NAKPlaybackIndicatorViewStateStopped;
    if([record.title isEqualToString:rc.title]){
        _lession2.state = NAKPlaybackIndicatorViewStatePlaying;
    }
    
    rc = [self.section.records objectAtIndex:2];
    
    _lession3.state = NAKPlaybackIndicatorViewStateStopped;
    if([record.title isEqualToString:rc.title]){
        _lession3.state = NAKPlaybackIndicatorViewStatePlaying;
    }
}

-(void)changeStateWith:(NSNumber *)musicid{
    RecordClass * rc = [self.section.records objectAtIndex:0];
    
    _lession1.state = NAKPlaybackIndicatorViewStateStopped;
    if([rc.music.musicId integerValue] == [musicid integerValue]){
        _lession1.state = NAKPlaybackIndicatorViewStatePlaying;
    }
    
    rc = [self.section.records objectAtIndex:1];
    
    _lession2.state = NAKPlaybackIndicatorViewStateStopped;

    if([rc.music.musicId integerValue] == [musicid integerValue]){
        _lession2.state = NAKPlaybackIndicatorViewStatePlaying;
    }
    rc = [self.section.records objectAtIndex:2];
    
    _lession3.state = NAKPlaybackIndicatorViewStateStopped;
    if([rc.music.musicId integerValue] == [musicid integerValue]){
        _lession3.state = NAKPlaybackIndicatorViewStatePlaying;
    }}

@end