//
//  WeeklyParticipantViewModal.swift
//  Plot story assistant
//
//  Created by webastral on 28/06/19.
//  Copyright © 2019 webastral. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import Firebase
class WeeklyParticipantViewModal: NSObject{
    
    var userId : String = ""
    
    var mostVotedArray = [WeeklyPartipantModel]()
    var recentArray = [WeeklyPartipantModel]()
    var myStoryArray = [WeeklyPartipantModel]()
    var listArr = [WeeklyPartipantModel]()
    
    var catagory = String()
    
     // MARK :- Get Weekly Most Voted Data
    
    func weeklyParticipantMostVoted(completion:@escaping completion){
       
        self.mostVotedArray.removeAll()
    UtilityMgr.fireStoreDB.collection("Weekly_Challenge_Beta_1").document("posts").collection("posts").getDocuments { (snapshot, error) in
    
            
         if let dataarr = snapshot?.documents{
            
            for data in dataarr{
                print(data.data())
            }
             let data =  dataarr.sorted(by: { (data1, data2) -> Bool in
               let like1 = data1.data()["likeCount"] as? Int ?? 0
               let like2 = data2.data()["likeCount"] as? Int ?? 0
               return like1 > like2
             })
            
               for dict in data{
                  let objWeeklyParticipantModal = WeeklyPartipantModel()
                print(dict.data())
                  objWeeklyParticipantModal.addWeeklyParticipant(dict: dict.data())
                  self.mostVotedArray.append(objWeeklyParticipantModal)
               }
            
            for (key,value) in self.mostVotedArray.enumerated(){
                self.addCommentData(key: key, value: value){
                    
                    if(key == 0){
                        
                          completion(true)
                    }
                }
            }
            
            self.setArrayData(Catagory: "Most")
          
         }else{
            completion(false)
            }
        }
    }
    
    func addCommentData(key:Int,value:WeeklyPartipantModel,completion:@escaping ()->()) {
        UtilityMgr.fireStoreDB.collection("Weekly_Challenge_Beta_1").document("post-comments").collection("post-comments").document(value.id).collection("Comments").getDocuments(completion: { (snapshots, err) in
            print(key)
            if let data = snapshots?.documents{
                //print(data.data())
//                print(data[0].data())
                 var commentList = [WeeklyParticipantComments]()
                if data.count > 0{
                    for comment in data {
                        let obj = WeeklyParticipantComments()
                        obj.addWeeklyParticipant(dict: comment.data())
                        commentList.append(obj)
                    }
                    self.listArr[key].commentList = commentList
                }
            }
            completion()
        })
    }
    
    // MARK :- Get Weekly Recent Data
    func weeklyParticipantRecent(completion:@escaping completion){
        
         self.recentArray.removeAll()
        UtilityMgr.fireStoreDB.collection("Weekly_Challenge_Beta_1").document("posts").collection("posts").order(by: "date", descending: true).getDocuments { (snapshot, error) in
            
            if let dataArr = snapshot?.documents{
                for dict in dataArr{
                    let objWeeklyParticipantModal = WeeklyPartipantModel()
                    objWeeklyParticipantModal.addWeeklyParticipant(dict: dict.data())
                    self.recentArray.append(objWeeklyParticipantModal)
                }
                
                for (key,value) in self.recentArray.enumerated(){
                    self.addCommentData(key: key, value: value){
                        
                        
                    }
                }
                
                 self.setArrayData(Catagory: "Recent")
                 completion(true)
            }else{
                 completion(false)
            }
        }
    }
    
    func weeklyParticipantMyStory(completion:@escaping completion){
        
        self.myStoryArray.removeAll()
        UtilityMgr.fireStoreDB.collection("Weekly_Challenge_Beta_1").document("posts").collection("posts").getDocuments { (snapshot, error) in
            
            if let dataarr = snapshot?.documents{
                for dict in dataarr{
                    print(dict.data())
                    print(dict.data()["id"])
                    print(Auth.auth().currentUser?.uid)
                    if let uid = dict.data()["user"] as? [String:Any]{
                        print(uid["uid"] as? String ?? "")
                        self.userId = Auth.auth().currentUser?.uid ?? ""
                        if self.userId == uid["uid"] as? String ?? ""{
                            let objWeeklyParticipantModal = WeeklyPartipantModel()
                            objWeeklyParticipantModal.addWeeklyParticipant(dict: dict.data())
                            self.myStoryArray.append(objWeeklyParticipantModal)
                            print(self.myStoryArray.count)
                        }
                    }
                    
                    for (key,value) in self.myStoryArray.enumerated(){
                        self.addCommentData(key: key, value: value){
                            
                            
                        }
                    }
                    
                    self.setArrayData(Catagory: "MyStory")
                }
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    func setArrayData(Catagory:String) {
        if Catagory == "Most"{
            listArr = mostVotedArray
        }else if Catagory == "Recent"{
            listArr = recentArray
        }else if Catagory == "MyStory"{
            listArr = myStoryArray
        }
        catagory = Catagory
    }
    
    //Mark :- Most Voted Properties
    
    func numberOfRows() -> Int {
       return self.listArr.count
    }
    
    func getName(index:Int)-> String{
     return self.listArr[index].name
    }
    func getProfileImg(index:Int)->String{
        return self.listArr[index].uriString
    }
    func getTitle(index:Int)->String{
        return self.listArr[index].title
    }
    
    func getStory(index:Int)->String{
        return self.listArr[index].story
    }
    
    func getLikeCount(index:Int)-> Int{
        return self.listArr[index].likeCount
    }
    
    func setLikeCount(index:Int,value:Int){
        if catagory == "Most"{
            self.mostVotedArray[index].likeCount = value
            listArr = mostVotedArray
        }else if catagory == "Recent"{
            self.recentArray[index].likeCount = value
            listArr = recentArray
        }else if catagory == "MyStory"{
            self.myStoryArray[index].likeCount = value
            listArr = myStoryArray
        }
    }
    
    func setIsLiked(index:Int,value:Bool){
        if catagory == "Most"{
            self.mostVotedArray[index].isLiked = value
            listArr = mostVotedArray
        }else if catagory == "Recent"{
            self.recentArray[index].isLiked = value
            listArr = recentArray
        }else if catagory == "MyStory"{
            self.myStoryArray[index].isLiked = value
            listArr = myStoryArray
        }
    }
    
    func getChallenge(index:Int)->String{
        return self.listArr[index].chalenge
    }
    
    func getCommentCount(index:Int)->Int{
        return self.listArr[index].commentList.count
    }
    
    func getPostId(index:Int)->String{
        return self.listArr[index].id
    }
    
    func getLikes(index:Int) -> [String:Any] {
        return self.listArr[index].likes
    }
    func getPostIsLiked(index:Int) -> Bool{
        return self.listArr[index].isLiked
    }
    
     //Mark :- Recent Properties
    
//    func getRecentName(index:Int)->String{
//        return recentArray[index].name
//    }
//    
//    func getRecentProfileImg(index:Int)->String{
//        return self.recentArray[index].uriString
//    }
//    func getRecentTitle(index:Int)->String{
//        return self.recentArray[index].title
//    }
//    func getRecentStory(index:Int)->String{
//        return self.recentArray[index].story
//    }
//    func getRecentLikeCount(index:Int)-> Int{
//        return self.recentArray[index].likeCount
//    }
//    func getRecentChallenge(index:Int)->String{
//        return self.recentArray[index].chalenge
//    }
//    
//    func getRecentCommentCount(index:Int)->Int{
//        return self.recentArray[index].likes.count
//    }
//    func getRecentPostIsLiked(index:Int) -> Bool{
//        return self.recentArray[index].isLiked
//    }
//    
//    //Mark :- My Story Properties
//    
//    func getMyStoryName(index:Int)->String{
//        return myStoryArray[index].name
//    }
//    
//    func getMyStoryProfileImg(index:Int)->String{
//        return self.myStoryArray[index].uriString
//    }
//    func getMyStoryTitle(index:Int)->String{
//        return self.myStoryArray[index].title
//    }
//    func getMyStoryStory(index:Int)->String{
//        return self.myStoryArray[index].story
//    }
//    func getMyStoryLikeCount(index:Int)-> Int{
//        return self.myStoryArray[index].likeCount
//    }
//    func getMyStoryChallenge(index:Int)->String{
//        return self.myStoryArray[index].chalenge
//    }
//    
//    func getMyStoryCommentCount(index:Int)->Int{
//        return self.myStoryArray[index].likes.count
//    }
//    func getMyStoryPostIsLiked(index:Int) -> Bool{
//        return self.myStoryArray[index].isLiked
//    }
    
    
    func insertNewComment(dict:[String:Any],index:Int){
        let obj = WeeklyParticipantComments()
        obj.addWeeklyParticipant(dict:dict)
        listArr[index].commentList.insert(obj, at: 0)
    }
    
    //MARK:- Comments Properties
    
    
    func getUserComment(index:Int,subIndex:Int)-> String{
       return listArr[index].commentList[subIndex].userComment
    }
    func getUserCommentDate(index:Int,subIndex:Int)-> String{
        return listArr[index].commentList[subIndex].userDate
    }
    func getUserCommentPic(index:Int,subIndex:Int)-> String{
        return listArr[index].commentList[subIndex].userPic
    }
    func getUserCommentId(index:Int,subIndex:Int)-> String{
        return listArr[index].commentList[subIndex].userId
    }
    func getUserCommentName(index:Int,subIndex:Int)-> String{
        return listArr[index].commentList[subIndex].userName
    }
}
