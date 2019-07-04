//
//  SocialLogin.swift
//  Stocks Club
//
//  Created by webastral on 21/06/19.
//  Copyright © 2019 webastral. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
@objc protocol SocialLoginDelegate{
    @objc optional func googleSignedIn(data:[String:Any]?,error:Error?)
}

class SocialLogin: NSObject,GIDSignInDelegate,GIDSignInUIDelegate{
    
    var delegate:SocialLoginDelegate? = nil
    var objUserDetails = UserDetailModel()
    var objUtilitymgr = UtilityMgr()
    
    func googleSignIn(){
     
     GIDSignIn.sharedInstance().delegate=self
     GIDSignIn.sharedInstance().uiDelegate=self
     GIDSignIn.sharedInstance().signIn()
     }
  
     // MARK:- Goolgle SignIn Delegate Methods
     
     func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
     print(error)
     
     }
     
     func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
     
        UtilityMgr.topController?.present(viewController, animated: true, completion: nil)
     }
     
     
     func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
     
        UtilityMgr.topController?.dismiss(animated: true, completion: nil)
     }
     
     
     func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
     
        if (error == nil) {
            print(user)
            
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
            print(user.profile)
            print(credential.provider)
            
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    print(error)
                    return
                }else{
                    print(authResult?.additionalUserInfo)
                    print(authResult?.user.email ?? "")
                }
            }
            // Perform any operations on signed in user here.
            let userId = user.userID  ?? ""                // For client-side use only!
            let idToken = user.authentication.idToken  ?? ""// Safe to send to the server
            let fullName = user.profile.name ?? ""
            let givenName = user.profile.givenName ?? ""
            let familyName = user.profile.familyName ?? ""
            let email = user.profile.email ?? ""
            let accessToken = user.authentication.accessToken ?? ""
            let refreshToken = user.authentication.refreshToken ?? ""
            _ = signIn.scopes
            
            GIDSignIn.sharedInstance().signOut()
            
            var imageURL = ""
            if user.profile.hasImage {
                imageURL = user.profile.imageURL(withDimension: 100).absoluteString
            }
            
            
            let dataDict = ["id":userId,"fullName":fullName,"givenName":givenName,"familyName":familyName,"email":email,"imageUrl":imageURL,"authToken":idToken,"accessToken":accessToken,"refreshToken":refreshToken] as [String : Any]
           
            objUserDetails.addUserDetails(dict: dataDict)
         
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.objUserDetails) {
                UserDefaults.standard.set(encoded, forKey: "loginUserDetail")
            }
            
             print(UtilityMgr.LoginUserDecodedDetail().email)
            print(dataDict)
           
            if let objDelegate = delegate{
                objDelegate.googleSignedIn!(data:dataDict, error: nil)
            }
        else {
            print(error.localizedDescription)
            if let objDelegate = delegate{
                objDelegate.googleSignedIn!(data:nil, error: error)
            }
        }
        }else{
            print("Already SignIned")
        }
    }
    
}


