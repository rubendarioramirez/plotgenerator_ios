//
//  WeeklyPartipantModel.swift
//  Plot story assistant
//
//  Created by webastral on 28/06/19.
//  Copyright © 2019 webastral. All rights reserved.
//

import Foundation
import Firebase

class WeeklyPartipantModel: NSObject{
    var genre :String = ""
    var likeCount:Int = 0
    var title:String = ""
    var name:String = ""
    var story:String = ""
    var picUrl:String = ""
    var chalenge:String = ""
    var id : String = ""
    var submitDate : Int = 0
    var likes = [String:Any]()
    var email : String = ""
    var uid : String = ""
    var uriString : String = ""
    var isLiked = Bool()
    
    var commentList = [WeeklyParticipantComments]()
    
    func addWeeklyParticipant(dict:[String:Any]){
        self.genre = dict["genre"]as? String ?? ""
        self.likeCount = dict["likeCount"]as? Int ?? 0
        self.title = dict["title"]as? String ?? ""
        id = dict["id"]as? String ?? ""
        if let like = dict["likes"] as? [String:Any]{
            self.likes = like
            var isExist = false
            for (_,value) in like.enumerated(){
                if value.key == Auth.auth().currentUser?.uid{
                    isExist = true
                }
            }
            
            if isExist{
                isLiked = true
            }else{
                isLiked = false
            }
        }
        if let user = dict["user"] as? [String:Any]{
            name = user["name"] as? String ?? ""
            self.picUrl = user["picUrl"]as? String ?? ""
            uid = user["uid"]as? String ?? ""
            uriString = user["uriString"]as? String ?? ""
        }
        submitDate = dict["submitDate"] as? Int ?? 0
        self.story = dict["story"]as? String ?? ""
        self.chalenge = dict["chalenge"] as? String ?? ""
        
    }
    
}

class WeeklyParticipantComments: NSObject {
    
    var userDate:String = ""
    var userPic:String = ""
    var userComment:String = ""
    var userName:String = ""
    var userId:String = ""
    
    func addWeeklyParticipant(dict:[String:Any]){
        
        self.userDate = dict["userDate"]as? String ?? ""
        self.userPic = dict["userPic"]as? String ?? ""
        self.userComment = dict["userComment"]as? String ?? ""
        self.userName = dict["userName"]as? String ?? ""
        self.userId = dict["userId"]as? String ?? ""
        
    }
}
