//
//  PhotosViewController.m
//  NYPeopleFeed
//
//  Created by Diego de Jesus Ramirez on 25/06/20.
//  Copyright © 2020 DiegoRamirez. All rights reserved.
//

#import "PhotosViewController.h"

@interface PhotosViewController ()
@property (strong, nonatomic) NSArray *posts;
@end

@implementation PhotosViewController

-(void) fetchPhotos {
    // Set the url for the network request
    NSURL *url = [NSURL URLWithString:@"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"];
    
    // Set the url request object
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    
    // Instantiate a session to make requests to the Movies API
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    // Task to request data to API and handle results
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               

               if ([dataDictionary[@"meta"][@"status"]  isEqual: @(200)]){
                   NSLog(@"%@", dataDictionary[@"response"][@"blog"]);
               } else {
                   NSLog(@"%@", dataDictionary[@"status"]);
                   NSLog(@"supsup");
               }
           }
        
       }];
    [task resume];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self fetchPhotos];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
