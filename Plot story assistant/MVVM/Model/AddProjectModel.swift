//
//  File.swift
//  Plot story assistant
//
//  Created by webastral on 11/5/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import Foundation

class AddProjectModel : Codable {
    
    var projectId : Int? = nil
    var projectName : String? = nil
    var genre : String? = nil
    var plotSummary : String? = nil
    
    init(projectId:Int? ,projectName:String ,genre:String? , plotSummary:String?) {
        self.projectId = projectId
        self.projectName = projectName
        self.genre = genre
        self.plotSummary = plotSummary
    }
}







