//
//  NewsAPIHandler.m
//  TheNewsApp
//
//  Created by Vijaya Madhavi on 09/07/22.
//

#import "APIHandler.h"

const NSString *topHeadlinesURL = @"https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=";

const NSString *movieBaseUrl = @"https://api.themoviedb.org/3/movie/";
const NSString *movieApiKey = "";

const NSString *popularMovieURL = @"https://api.themoviedb.org/3/movie/popular?api_key=&language=en-US&page=1";

const NSString *wsjNewsURL = @"https://newsapi.org/v2/everything?domains=wsj.com&apiKey=";

const NSString *topRatedMovieURL = @"https://api.themoviedb.org/3/movie/top_rated?api_key=&language=en-US&page=1";

@implementation APIHandler

+ (NSArray *)getTopHeadlines {
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
   [request setHTTPMethod:@"GET"];
   [request setURL:[NSURL URLWithString:topHeadlinesURL]];

   NSError *error = nil;
   NSHTTPURLResponse *responseCode = nil;

   NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
   
   if([responseCode statusCode] != 200){
       NSLog(@"Error getting %@, HTTP status code %ld", topHeadlinesURL, [responseCode statusCode]);
       return nil;
   }
    
    NSError *e = nil;

    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: oResponseData options: NSJSONReadingMutableContainers error: &e];
    return [jsonDict valueForKey:@"articles"];
}

+ (NSArray *)getWSJHeadlines {
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
   [request setHTTPMethod:@"GET"];
   [request setURL:[NSURL URLWithString:wsjNewsURL]];

   NSError *error = nil;
   NSHTTPURLResponse *responseCode = nil;

   NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
   
   if([responseCode statusCode] != 200){
       NSLog(@"Error getting %@, HTTP status code %ld", wsjNewsURL, [responseCode statusCode]);
       return nil;
   }
    
    NSError *e = nil;

    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: oResponseData options: NSJSONReadingMutableContainers error: &e];
    return [jsonDict valueForKey:@"articles"];
}

+ (NSArray *)getPopularMovies {
    NSString *popularUrl = [NSString stringWithFormat:@"%@popular?api_key=%@", movieBaseUrl, movieApiKey];
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
   [request setHTTPMethod:@"GET"];
   [request setURL:[NSURL URLWithString:popularUrl]];

   NSError *error = nil;
   NSHTTPURLResponse *responseCode = nil;

   NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
   
   if([responseCode statusCode] != 200){
       NSLog(@"Error getting %@, HTTP status code %ld", popularMovieURL, [responseCode statusCode]);
       return nil;
   }
    
    NSError *e = nil;

    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: oResponseData options: NSJSONReadingMutableContainers error: &e];
    return [jsonDict valueForKey:@"results"];
}

+ (NSArray *)getTopRatedMovies {
    NSString *topRatedUrl = [NSString stringWithFormat:@"%@top_rated?api_key=%@", movieBaseUrl, movieApiKey];
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
   [request setHTTPMethod:@"GET"];
   [request setURL:[NSURL URLWithString:topRatedUrl]];

   NSError *error = nil;
   NSHTTPURLResponse *responseCode = nil;

   NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
   
   if([responseCode statusCode] != 200){
       NSLog(@"Error getting %@, HTTP status code %ld", topRatedMovieURL, [responseCode statusCode]);
       return nil;
   }
    
    NSError *e = nil;

    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: oResponseData options: NSJSONReadingMutableContainers error: &e];
    return [jsonDict valueForKey:@"results"];
}

+ (NSArray *)getGenreWithMovieId:(NSString *)movieId {

    NSString *detailUrl = [NSString stringWithFormat:@"%@%@?api_key=%@", movieBaseUrl, movieId, movieApiKey];
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
   [request setHTTPMethod:@"GET"];
   [request setURL:[NSURL URLWithString:detailUrl]];

   NSError *error = nil;
   NSHTTPURLResponse *responseCode = nil;

   NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
   
   if([responseCode statusCode] != 200){
       NSLog(@"Error getting %@, HTTP status code %ld", detailUrl, [responseCode statusCode]);
       return nil;
   }
    
    NSError *e = nil;

    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: oResponseData options: NSJSONReadingMutableContainers error: &e];
    return [jsonDict valueForKey:@"genres"];
}

@end
