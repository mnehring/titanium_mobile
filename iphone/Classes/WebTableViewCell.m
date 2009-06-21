//
//  WebTableViewCell.m
//  Titanium
//
//  Created by Blain Hamon on 6/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WebTableViewCell.h"

NSString * const trueString = @"true";
NSString * const falseString = @"false";

@implementation WebTableViewCell
@synthesize htmlLabel;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier;
{
	self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier];
	if (self != nil){
		UIView * cellContentView = [self contentView];
		htmlLabel = [[UIWebView alloc] initWithFrame:[cellContentView frame]];
		[htmlLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
		[htmlLabel setAlpha:0.0];
		[htmlLabel setDelegate:self];
		[htmlLabel setExclusiveTouch:NO];
		[htmlLabel setUserInteractionEnabled:NO];
		[htmlLabel setBackgroundColor:[UIColor clearColor]];
		[htmlLabel setOpaque:NO];
		[cellContentView addSubview:htmlLabel];
	}
	return self;
}

- (void)prepareForReuse;
{
	[htmlLabel setAlpha:0.0];
	[super prepareForReuse];
}

- (void)setHighlighted:(BOOL)selected animated:(BOOL)animated;
{
	if (selected != [self isHighlighted]){
		NSString * command = [[NSString alloc] initWithFormat:@"setSelected(%@,%@)",(selected ? trueString : falseString),(animated ? trueString : falseString)];
		NSLog(@"Value from %@: %@",command,[htmlLabel stringByEvaluatingJavaScriptFromString:command]);
		[command release];
	}
	[super setHighlighted:selected animated:animated];
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
//{
//	if (selected != [self isSelected]){
//		NSString * command = [[NSString alloc] initWithFormat:@"setSelected(%@,%@)",(selected ? trueString : falseString),(animated ? trueString : falseString)];
//		NSLog(@"Typeof Setselected: %@",[htmlLabel stringByEvaluatingJavaScriptFromString:command]);
//		[command release];
//	}
//	[super setSelected:selected animated:animated];
//}

//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;


- (void)dealloc {
	[htmlLabel setDelegate:nil];
	[htmlLabel release];
    [super dealloc];
}

- (void)webViewDidFinishLoad:(UIWebView *)inputWebView;
{
	[UIView beginAnimations:@"webView" context:nil];
	[inputWebView setAlpha:1.0];
	[UIView commitAnimations];
}	

@end
