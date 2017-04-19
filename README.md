# allObjcModel



// When you are calling use this code.


MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    
    NSDictionary *dicPara = [[NSDictionary alloc]initWithObjectsAndKeys:_txtMobile.text,@"mobile", nil];
    [[singletone sharedManager] WSResponse:kServiceNameLoginVerification Parameters:dicPara Success:^(NSDictionary *dicResult) {
    
        
        NSLog(@"%@",dicResult);
        
        if([[dicResult valueForKey:@"code"] integerValue] == 1)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            CodeConVC *codeVc = [self.storyboard instantiateViewControllerWithIdentifier:@"CodeConVC"];
            codeVc.dicData = dicResult;
            [self.navigationController pushViewController:codeVc animated:YES];
        }
        
        
        
    } Failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
