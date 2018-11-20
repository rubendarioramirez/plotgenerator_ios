//
//  AddCreateCharacter.swift
//  Plot story assistant
//
//  Created by webastral on 11/6/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import Foundation

class AddCreateCharacterModel : Codable {
    
    var id : Int? = nil
    var username : String? = nil
    var age : String? = nil
    var gender: String? = nil
    var profession : String? = nil
    var placeofbirth : String? = nil
    var catchphrase : String?  = nil
    var trait : String?  = nil
    var trait1 : String?  = nil
    var trait2 : String?  = nil
    var guideType : String?  = nil
    var defmoment : String?  = nil
    var desire : String?  = nil
    var desire1 : String?  = nil
    var notes : String?  = nil
    var projectId : Int? = nil
    
 init(id:Int?,username:String?,age:String?,gender:String?,profession:String,placeofbirth:String,catchphrase:String?,trait:String?,trait1:String?,trait2:String?,guideType:String?,defmoment:String?,desire:String?,desire1:String?,notes:String?,projectId:Int?) {
        
    self.id = id
    self.username = username
    self.age = age
    self.gender = gender
    self.profession = profession
    self.placeofbirth = placeofbirth
    self.catchphrase = catchphrase
    self.trait = trait
    self.trait1 = trait1
    self.trait2 = trait2
    self.guideType = guideType
    self.defmoment = defmoment
    self.desire = desire
    self.desire1 = desire1
    self.notes = notes
    self.projectId = projectId
    }
    
}


class questionModel : Codable{
    
    var quest : String? = nil
    var answer : String? = nil
    var projId : Int? = nil
    var bioId : Int? = nil
    var questId : Int? = nil
    var challengeId : Int? = nil
    var title : String? = nil
    
    func set(dict:[String:Any]){
        quest = dict["quest"] as? String
        answer = dict["answer"] as? String
        bioId = dict["bioId"] as? Int
        projId = dict["projId"] as? Int
        questId = dict["questId"] as? Int
        challengeId = dict["challengeId"] as? Int
        title = dict["title"] as? String
    }
}

class questBioModel : Codable{
    
    var quest : String? = nil
    var answer : String? = nil
    var projId : Int? = nil
    var bioId : Int? = nil
    var questId : Int? = nil
    var challengeId : Int? = nil
    
    func set(dict:[String:Any]){
        quest = dict["quest"] as? String
        answer = dict["answer"] as? String
        bioId = dict["bioId"] as? Int
        projId = dict["projId"] as? Int
        questId = dict["questId"] as? Int
        challengeId = dict["challengeId"] as? Int
       // title = dict["title"] as? String
    }
}






