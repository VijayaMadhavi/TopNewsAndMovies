//
//  APIHandler.h
//  TheNewsApp
//
//  Created by Vijaya Madhavi on 09/07/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIHandler : NSObject

+ (NSArray *)getTopHeadlines;
+ (NSArray *)getWSJHeadlines;

+ (NSArray *)getPopularMovies;
+ (NSArray *)getTopRatedMovies;
+ (NSDictionary *)getGenreWithMovieId:(NSString *)movieId;
@end

NS_ASSUME_NONNULL_END
