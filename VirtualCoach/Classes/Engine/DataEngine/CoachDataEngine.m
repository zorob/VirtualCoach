//
//  CoachDataEngine.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "CoachDataEngine.h"
#import "CoachPlayerDAO.h"
#import "VideoReferenceDAO.h"
#import "PlayerDAO.h"

@implementation CoachDataEngine

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _coachDAO = [[CoachDAO alloc] init];
    }
    
    return self;
}

//INSERT
-(id)insertCoach:(CoachDO*)coachDO
{
    NSString *leftHanded = @"0";
    if(coachDO.leftHanded == YES){
        leftHanded= @"0";
    }
    else{
        leftHanded = @"1";
    }
    return [_coachDAO insertIntoCoach:coachDO.name firstName:coachDO.firstName leftHanded:leftHanded login:coachDO.login password:coachDO.password];
}

//SELECT
-(NSMutableArray<CoachDO*>*)selectAllCoaches
{

    CoachPlayerDAO *coachPlayerDAO = [[CoachPlayerDAO alloc] init];
    CoachDO *coachDO;
    PlayerDAO *playerDAO = [[PlayerDAO alloc] init];
    PlayerDO *playerDO;
    VideoReferenceDAO *videoRefDAO = [[VideoReferenceDAO alloc] init];
    ReferenceVideoDO *videoRefDO;
    NSMutableArray<PlayerDO*> *arrayPlayerDO = [[NSMutableArray<PlayerDO*> alloc] init];
    NSMutableArray<CoachDO*> *arrayCoachDO = [[NSMutableArray<CoachDO*> alloc] init];
    NSMutableArray<ReferenceVideoDO*>* arrayVideoReferenceDO = [[NSMutableArray<ReferenceVideoDO*> alloc] init];
    
    NSArray *allCoaches = [_coachDAO allCoaches];
    
    for(int i = 0; i<[allCoaches count]; i++){
        for(int j = 0; j<[allCoaches[i] count]; j++){
           NSString * coachId = [allCoaches[0][j] stringValue];
           NSArray *playesId = [coachPlayerDAO searchIdPlayersByCoach:coachId];
        
            for (int p=0; p<[playesId[0] count]; p++) {
                NSString *idPlayer = [playesId[0][p] stringValue];
                
                NSArray *onePlayer = [playerDAO searchPlayerById:idPlayer];
                
                bool leftHanded = YES;
                if([onePlayer[3][0] intValue] == 1){
                    leftHanded = NO;
                }
                playerDO = [[PlayerDO alloc] initWithId:[playesId[0][p] intValue] andName:onePlayer[1][0] andFirstName:onePlayer[2][0] andLeftHanded:leftHanded andStatistics:nil andTrophies:nil];
                [arrayPlayerDO addObject:playerDO];
                
            }
            
            NSArray *videosRef = [videoRefDAO searchVideoRefByIdCoach:coachId];
            
            for (int k=0; k<[videosRef count]; k++) {
                for (int kk=0; kk<[videosRef[k] count]; kk++) {
                    
                    bool processed = YES;
                    bool removed = YES;
                    
                    if([videosRef[2][kk] integerValue] == 1){
                        processed= NO;
                    }
                    
                    if([videosRef[3][kk] integerValue] == 1){
                        removed= NO;
                    }
                    
                    // @Lala
                    // Replace the following variables with real day, month and year
                    int day = 0;
                    int month = 0;
                    int year = 0;
                    
                    int idVideoRef = [videosRef[0][kk] intValue];
                    videoRefDO = [[ReferenceVideoDO alloc] initWithId:idVideoRef andName:videosRef[1][kk] andProcessed:processed andRemoved:removed andDay:day andMonth:month
                                                              andYear:year andReferenceMovements:nil];
                    [arrayVideoReferenceDO addObject:videoRefDO];
                }
            }
            
            coachDO = [[CoachDO alloc] initWithCoachId:(int)[[allCoaches objectAtIndex:0] objectAtIndex:j] andName:allCoaches[1][j] andFirstName:allCoaches[2][j] andLogin:allCoaches[4][j] andPassword:allCoaches[5][j] andLeftHanded:allCoaches[3][j] andPlayers:arrayPlayerDO andReferenceVideos:arrayVideoReferenceDO];
            
            [arrayCoachDO addObject:coachDO];
            
           
        }
    }
    NSLog(@"Size: result: %lu", (unsigned long)arrayCoachDO.count);
    return arrayCoachDO;
    
}

//DELETE
-(id)deleteCoachById:(int)idCoach
{
    return [_coachDAO deleteCoachById:[NSString stringWithFormat:@"%i", idCoach]];
}

@end
