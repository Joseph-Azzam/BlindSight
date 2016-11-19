//
//  MainViewController.m
//  BlindSight
//
//  Created by Joseph Azzam on 2013-12-26.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<NSXMLParserDelegate>

@end

@implementation MainViewController
//Outlets
@synthesize UIV1;
@synthesize UIV2;
//Properties
@synthesize Example1;
@synthesize Example2;
@synthesize Buffer;
@synthesize  UI1, UI2, UI3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSXMLParser *parser=[[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"localhost:8888/Xcode/BSI.xml"]];
    parser.delegate=self;
    
    Buffer=nil;
    
    
    [parser parse];
    
    [UIV1 setImage:[UIImage imageNamed:@"1a.jpg"]];
    [UIV2 setImage:[UIImage imageNamed:@"1b.jpg"]];
/*
    [UIV1 setImage:[UIImage imageNamed:[Example1 objectAtIndex:0]]];
    [UIV2 setImage:[UIImage imageNamed:[Example1 objectAtIndex:0]]];
 */

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
////
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"Example1"])
    {
        [Example1 addObject:Buffer];
        Buffer=nil;
    }
    if ([elementName isEqualToString:@"Example2"])
    {
        [Example2 addObject:Buffer];
        Buffer=nil;
    }
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"Example1"] || [elementName isEqualToString:@"Example2"]){
        Buffer=[[NSMutableString alloc] init];
    }
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [Buffer appendString:string];
}
- (IBAction)UIVB1:(id)sender
{/*
    UI1 = [UIImage imageNamed:[Example1 objectAtIndex:0]];
    UI2 = [UIImage imageNamed:[Example1 objectAtIndex:1]];
    UI3 = [UIImage imageNamed:[Example1 objectAtIndex:2]];*/
    UI1 = [UIImage imageNamed:@"1a.jpg"];
    UI2 = [UIImage imageNamed:@"2a.jpg"];
    UI3 = [UIImage imageNamed:@"3a.jpg"];
}

- (IBAction)UIVB2:(id)sender
{/*
    UI1 = [UIImage imageNamed:[Example2 objectAtIndex:0]];
    UI2 = [UIImage imageNamed:[Example2 objectAtIndex:1]];
    UI3 = [UIImage imageNamed:[Example2 objectAtIndex:2]];*/
    UI1 = [UIImage imageNamed:@"1b.jpg"];
    UI2 = [UIImage imageNamed:@"2b.jpg"];
    UI3 = [UIImage imageNamed:@"3b.jpg"];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PlayerSegue"] )
    {
        PlayerViewController *PVC = [segue destinationViewController];
        PVC.image1 = UI1;
        PVC.image2 = UI2;
        PVC.image3 = UI3;
    }
}

@end
