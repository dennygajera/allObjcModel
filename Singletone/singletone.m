//
//  singletone.m
//  GPSTracker
//
//  Created by peacock on 26/10/15.
//  Copyright © 2015 peacock. All rights reserved.
//

#import "singletone.h"
#import <UIKit/UIKit.h>



@implementation singletone

@synthesize WebService;


+ (singletone*)sharedManager {
    static singletone *staticManager = nil;
    static dispatch_once_t onceToken;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    dispatch_once(&onceToken, ^{
        staticManager = [[self alloc] init];
    });
    return staticManager;
}

-(id)init
{
    self = [super init];
    
//  NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
//    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    if (self)
    {
        
            WebService = @"http://data.swaminarayan.me/Accounting.asmx/";
    }
    return self;
}



-(NSString *)getData:(NSString *)operationName : (NSDictionary *)data
{
    WebService = [WebService stringByAppendingString:operationName];
    
    for (int i=0;i<[data count];i++)
    {
        NSString *key  =  [[data allKeys] objectAtIndex:i];
        NSString *value = [[data allValues] objectAtIndex:i];
        NSString *strSingleObj  =  [NSString stringWithFormat:@"&%@=%@",key,value];
        WebService = [WebService stringByAppendingString:strSingleObj];
    }
    NSLog(@"%@",WebService);
    return WebService;
    
}




#pragma InternetConnection Check
- (BOOL) connectedToInternet {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}




#pragma mark - Scroll View
-(void)setUpScrollView : (int)xPosition withSelfView : (UIView *)selfView withScrollView : (UIScrollView *)scrollView
{
    NSMutableArray *arrayOfViews = [[NSMutableArray alloc]init];
    NSArray *images = [[NSArray alloc]initWithObjects:@"logoWorkers@2x.png",@"logoFriends@2x.png",@"logoFamily@2x.png", nil];
    for (int i = 0; i<3; i++)
    {
        //Views
        UIView *views = [[UIView alloc]initWithFrame:CGRectMake(xPosition, 0, selfView.frame.size.width, scrollView.frame.size.height)];
        
        //ImageView
        UIImage *imageForScrollView = [UIImage imageNamed:[images objectAtIndex:i]];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((views.frame.size.width - imageForScrollView.size.width) / 2, (views.frame.size.height - imageForScrollView.size.height ) / 2, imageForScrollView.size.width,imageForScrollView.size.height)];
        imageView.image = imageForScrollView;
        [views addSubview:imageView];
        
        [arrayOfViews addObject:views];
        xPosition += selfView.frame.size.width;
        
        [scrollView addSubview:views];
    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * arrayOfViews.count, scrollView.frame.size.height);
}



#pragma mark - Validation For Email & contact Number.
-(BOOL) isValidEmail : (NSString *)testStr
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" argumentArray:@[emailRegEx]];

    return [emailTest evaluateWithObject:testStr];
}
-(BOOL)isValidContactNo : (NSString *)testStr
{
    NSString *phoneNoRegEx = @"^\\d{3}\\d{3}\\d{4}$";
    NSPredicate *PhTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" argumentArray:@[phoneNoRegEx]];
    BOOL f  = [PhTest evaluateWithObject:testStr];
    return f;
}

-(BOOL)isEmpty : (NSString *)testStr
{
    if ([testStr isEqualToString:@""])
    {
        return true;
    }
    else
    {
        return false;
    }
}

-(BOOL)isPasswordMatch:(NSString *)password :(NSString *)confirmPassword
{
    if ([password isEqualToString:confirmPassword]) {
        return false;
    }
    else
    {
        return true;
    }
}

-(void)setUpView : (UIView *)RquestView
{
    RquestView.layer.borderColor = [UIColor colorWithRed:97/255.f green:97/255.f blue:98/255.f alpha:1.0].CGColor;
    RquestView.layer.borderWidth = 2.0;
    RquestView.backgroundColor = [UIColor colorWithRed:45/255.f green:45/255.f blue:45/255.f alpha:0.6];
    RquestView.clipsToBounds = YES;
    RquestView.layer.cornerRadius = 4.0;
}
-(void)showAlert :(NSString *)title withMsg : (NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    alert.tintColor = [UIColor greenColor];
    [alert show];
}

-(BOOL)isiPad
{
    return [[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

-(CGFloat)getScreenHeight
{
    CGRect screenrect = [[UIScreen mainScreen] bounds];
    return screenrect.size.height;
}

-(CGFloat)getScreenWidth
{
    CGRect screenrect = [[UIScreen mainScreen] bounds];
    return screenrect.size.width;
}



-(void)redBorder : (UITextField *)textField
{
    textField.layer.borderColor  =[[UIColor redColor] CGColor];
    textField.layer.borderWidth = 1.0;
}

-(void)clearBorder : (UITextField *)textField
{
    textField.layer.borderColor  =[[UIColor colorWithRed:200/255.0 green:201/255.0 blue:202/255.0 alpha:1.0] CGColor];
    textField.layer.borderWidth = 1.0;
}


-(void)redBordertxtView : (UITextView *)textField
{
    textField.layer.borderColor  =[[UIColor redColor] CGColor];
    textField.layer.borderWidth = 1.0;
}

-(void)clearBordertxtview : (UITextView *)textField
{
    textField.layer.borderColor  =[[UIColor colorWithRed:200/255.0 green:201/255.0 blue:202/255.0 alpha:1.0] CGColor];
    textField.layer.borderWidth = 1.0;
}

-(void)redBorderLable : (UILabel *)label
{
    label.backgroundColor = [UIColor redColor];
}
-(void)clearBorderLable : (UILabel *)label
{
    label.backgroundColor = [UIColor blackColor];
}


-(void)redBorderButton : (UIButton *)btn
{
    btn.layer.borderColor  =[[UIColor redColor] CGColor];
    btn.layer.borderWidth = 1.0;
}
-(void)clearBorderButton : (UIButton *)btn
{
    btn.layer.borderColor  =[[UIColor colorWithRed:200/255.0 green:201/255.0 blue:202/255.0 alpha:1.0] CGColor];
    btn.layer.borderWidth = 1.0;
}



-(void)borderColor : (id)sender : (UIColor *)color
{
    if ([sender isKindOfClass:[UITextView class]]) {
        UITextView *txtView = sender;
        txtView.layer.borderColor= [color CGColor];
        txtView.layer.borderWidth = 1.0;
    }
    else if([sender isKindOfClass:[UITextField class]]) {
        
        UITextField *txtField = sender;
        txtField.layer.borderColor= [color CGColor];
        txtField.layer.borderWidth = 1.0;
    }
    else if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *txtField = sender;
        txtField.layer.borderColor= [color CGColor];
        txtField.layer.borderWidth = 1.0;
    }
    else if ([sender isKindOfClass:[UIView class]]) {
        UIView *txtField = sender;
        txtField.layer.borderColor= [color CGColor];
        txtField.layer.borderWidth = 1.0;
    }
}


-(void)textFieldPadding:(UITextField *)textField :(CGFloat)position :(NSString *)placeholder {
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, position, 20)];
    textField.leftView = paddingView;
    textField.placeholder = placeholder;
    textField.leftViewMode = UITextFieldViewModeAlways;
}


- (void)getDevicesForUserID:(NSString *)userID
                    success:(void (^)(NSArray* devices))successBlock
                    failure:(tFailureBlock)failureBlock
{
    
}


-(void)WSResponse : (NSString *)methodName
       Parameters :(NSDictionary *)diPara
          Success :(myCompletion) compblock
          Failure : (tFailureBlock)failureBlock
{
    
    @try
    {
        
        
        

        
        
        if([self connectedToInternet])
        {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        [manager.operationQueue cancelAllOperations];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        [manager.requestSerializer setTimeoutInterval:300];  //Time out after 5 MINUTES
        NSString *setUrl;
        
        setUrl = [NSString stringWithFormat:@"%@%@",WsCalling,methodName];
        
        __block NSMutableArray* json;
        json = [[NSMutableArray alloc]init];
        
        
        [manager POST:setUrl parameters:diPara success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSError *writeError = nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&writeError];
            
            NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:jsonData
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&writeError];
            
//            NSLog(@"%@",dicResult);
            
            compblock(dicResult);
            
            
            
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failureBlock(error);
            NSLog(@"Error: %@", error);
        }];
    }
        else
        {
            [[singletone sharedManager]showAlert:@"MOJO" withMsg:@"Please Connect To Internet"];
            NSError *erro;
            failureBlock(erro);
        }
    }
    
    @catch (NSException * e)
    {
        
        NSLog(@"%@",e.description);
    }
}


-(NSDictionary *)getCurrentLocation
{
    CLLocationManager *locationManager = [[CLLocationManager alloc]init];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    //NSLog(@”dLatitude : %@”, latitude);
    //NSLog(@”dLongitude : %@”,longitude);
    NSLog(@"MY HOME :%@", latitude);
    NSLog(@"MY HOME: %@ ", longitude);
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:latitude,@"lat",longitude,@"long",nil];
    return dic;
}


-(NSString *)arrayToString : (id)array
{
 
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:&error];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}



-(NSString *)getUniqueDeviceIdentifierAsString
{
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    NSString *strApplicationUUID = [SSKeychain passwordForService:appName account:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SSKeychain setPassword:strApplicationUUID forService:appName account:@"incoding"];
    }
    
    return strApplicationUUID;
}


/*- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 6;
}
*/



// ActionSheet

/*[ActionSheetStringPicker showPickerWithTitle:@"Select a city"
 rows:arrayTemp
 initialSelection:0
 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
 
 
 selectedCity = [arr objectAtIndex:selectedIndex];
 
 [_btnCity setTitle:[selectedCity valueForKey:@"city_name"] forState:UIControlStateNormal];
 
 }
 cancelBlock:^(ActionSheetStringPicker *picker) {
 [_btnCity setTitle:@"city" forState:UIControlStateNormal];
 
 }
 origin:_btnCity]; */
@end
