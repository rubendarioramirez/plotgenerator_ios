//
//  WeeklyChallengedModel.swift
//  Plot story assistant
//
//  Created by webastral on 27/06/19.
//  Copyright © 2019 webastral. All rights reserved.
//

import Foundation

class WeeklyChallengedModel:NSObject{
    
    var title:String?
    var body:String?
    var author : String = ""
    
    func addData(dict:[String:Any]){
        title = dict["title"] as? String ?? ""
        body = dict["body"] as? String ?? ""
        author = dict["author"] as? String ?? ""
        
    }
    
}



