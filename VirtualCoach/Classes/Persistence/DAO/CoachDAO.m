//
//  CoachDAO.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "CoachDAO.h"


@implementation CoachDAO

//INSERT
-(id)insertIntoCoach:(NSString *) name firstName:(NSString *) fname leftHanded:(NSString *) lh login:(NSString *) log password:(NSString *) pass
{
    NSString *query = @"insert into Coach values (null,'";
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:fname];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:lh];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:log];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:pass];
    query = [query stringByAppendingString:@"');"];
    
    NSNumber *insertion = [DatabaseService query:query mode:VCQueryNoMode];
    
    return insertion;
}

//SELECT
-(NSArray *) allCoaches
{
    NSString *query = @"select * from Coach;";
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;

}

-(int)searchIdByLogin:(NSString *) log password:(NSString *) pass
{
    NSString *query = @"select idCoach from Coach where login='";
    query = [query stringByAppendingString:log];
    query = [query stringByAppendingString:@"' and password='"];
    query = [query stringByAppendingString:pass];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    int desc = (int) [result[0][0] longValue];
    
    return desc;
}

//DELETE
-(id)deleteCoachById:(NSString *) idCoach
{
    NSString *query =@"delete from Coach where idCoach ='";
    query = [query stringByAppendingString:idCoach];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
    
}


@end
