//
//  singletone.h
//  GPSTracker
//
//  Created by peacock on 26/10/15.
//  Copyright © 2015 peacock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface singletone : NSObject
{
    NSString *lati;
    NSString *longi;
    
}
@property(nonatomic,retain) NSString *WebService;
typedef void(^myCompletion)(NSDictionary *dicResult);
typedef void(^tFailureBlock)(NSError *error);

//Methods
+ (singletone*)sharedManager;
-(id)init;
-(void)setUpScrollView : (int)xPosition withSelfView : (UIView *)selfView withScrollView : (UIScrollView *)scrollView;

//Validation
-(BOOL) isValidEmail : (NSString *)testStr;
-(BOOL)isValidContactNo : (NSString *)testStr;
-(BOOL)isPasswordMatch:(NSString *)password :(NSString *)confirmPassword;
-(BOOL)isEmpty : (NSString *)testStr;
-(void)showAlert :(NSString *)title withMsg : (NSString *)message;
-(void)setUpView : (UIView *)RquestView;
-(void)setWebService : (NSString *)customWs;
-(BOOL)isiPad;
-(CGFloat)getScreenHeight;
-(CGFloat)getScreenWidth;

-(void)redBorder : (UITextField *)textField;
-(void)clearBorder : (UITextField *)textField;

-(void)redBordertxtView : (UITextView *)textField;
-(void)clearBordertxtview : (UITextView *)textField;

-(void)redBorderButton : (UIButton *)btn;
-(void)clearBorderButton : (UIButton *)btn;

-(void)redBorderLable : (UILabel *)label;
-(void)clearBorderLable : (UILabel *)label;

-(void)borderColor : (id)sender : (UIColor *)color;
-(NSString *)getData:(NSString *)operationName : (NSDictionary *)data;

-(void)textFieldPadding:(UITextField *)textField :(CGFloat)position :(NSString *)placeholder;

-(void)WSResponse : (NSString *)methodName
       Parameters :(NSDictionary *)diPara
          Success :(myCompletion) compblock
          Failure : (tFailureBlock)failureBlock;
-(NSDictionary *)getCurrentLocation;
- (BOOL)connected;
-(NSString *)arrayToString : (id)array;

-(NSString *)getUniqueDeviceIdentifierAsString;
@end
