
import Foundation


class UserDetailModel: Codable {
    
    var id:String = ""
    var givenName:String = ""
    var familyName:String = ""
    var imageUrl:String = ""
    var fullName:String = ""
    var authToken:String = ""
    var refreshToken:String = ""
    var email:String = ""
    
    func addUserDetails(dict:[String:Any]){
        print(dict)
        id = dict["id"] as? String ?? ""
        print(id)
        givenName = dict["givenName"] as? String ?? ""
         print(givenName)
        familyName = dict["familyName"]as? String ?? ""
        print(familyName)
        imageUrl = dict["imageUrl"]as? String ?? ""
        print(imageUrl)
        fullName = dict["fullName"]as? String ?? ""
        print(fullName)
        authToken = dict["authToken"]as? String ?? ""
        print(authToken)
        refreshToken = dict["refreshToken"]as? String ?? ""
        print(refreshToken)
        email = dict["email"]as? String ?? ""
        print(email)
    
    }
    
}
