//
//  ShowQuestionDataModel.swift
//  Plot story assistant
//
//  Created by webastral on 11/13/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import Foundation


class ShowQuestModel : Codable{
    
    var Id : Int? = nil
    var Question : String? = nil
    var Asnwer:String? = nil
    var bioId : Int? = nil
    var projectid : Int? = nil
    var challengeId : Int? = nil
    
    init(Id:Int?,Question:String?,Asnwer:String?,bioId:Int?,projectid:Int?,challengeId:Int?) {
        self.Id = Id
        self.Question = Question
        self.Asnwer = Asnwer
        self.bioId = bioId
        self.projectid = projectid
        self.challengeId = challengeId
    }
    
}
