//
//  AddProjectViewModel.swift
//  Plot story assistant
//
//  Created by webastral on 11/5/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import SQLite3
import IQKeyboardManagerSwift

class DataViewModel: NSObject {
    
    var db: OpaquePointer?
    
     var projectListArray = [AddProjectModel]()
    
     var createCharacterArray = [AddCreateCharacterModel]()
    
     var questDataArray = [ShowQuestModel]()
    var titleNavigtionName = String()
    
    var challengeId : Int = 0
    var questId = Array<Int>()
    
    
    static func shared() -> DataViewModel {
        struct Static {
            static let manager = DataViewModel()
        }
        return Static.manager
    }
    
    
    func createDatabase(tbl:UITableView? = nil){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("PlotStoryAssistant.sqlite")
        
        print(fileURL.path)
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Contact (projectid INTEGER PRIMARY KEY AUTOINCREMENT, projectname VARCHAR, genre VARCHAR, plotsummary VARCHAR)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS createCharacter (Id INTEGER PRIMARY KEY AUTOINCREMENT, username VARCHAR, age VARCHAR, gender VARCHAR, profession VARCHAR, placeofbirth VARCHAR, catchphrase VARCHAR, trait VARCHAR, trait1 VARCHAR, trait2 VARCHAR, guideType VARCHAR, defmoment VARCHAR, desire VARCHAR, desire1 VARCHAR, notes VARCHAR, projectid INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS CharacterQuest (Id INTEGER PRIMARY KEY AUTOINCREMENT, Question VARCHAR, Asnwer VARCHAR, bioId INTEGER, projectid INTEGER, challengeId INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
      query(tbl: tbl) { (status) in
            tbl?.reloadData()
        }
        
    }
    
    
    func showQuestTblData(bioId:Int,tbl:UITableView? = nil) {
        questDataArray.removeAll()
        var queryStatement: OpaquePointer?
        let queryStatementString = "SELECT * FROM CharacterQuest WHERE bioId=\(bioId)"
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while(sqlite3_step(queryStatement) == SQLITE_ROW){
                let id = sqlite3_column_int(queryStatement, 0)
                questId.append(Int(id))

                let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
                let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
                let queryResultCol3 = sqlite3_column_int(queryStatement, 3)
                let queryResultCol4 = sqlite3_column_int(queryStatement, 4)
                let queryResultCol5 = sqlite3_column_int(queryStatement, 5)
                 challengeId = Int(queryResultCol5)
                
                var questionString = String()
                if queryResultCol1 != nil{
                    questionString = String(cString: queryResultCol1!)
                }
                var answerString = String()
                if queryResultCol2 != nil{
                    answerString = String(cString: queryResultCol2!)
                }
                
                
                questDataArray.append(ShowQuestModel(Id: Int(id), Question: questionString, Asnwer: answerString, bioId: Int(queryResultCol3), projectid: Int(queryResultCol4), challengeId: Int(queryResultCol5)))
            }
            
        } else {
            print("SELECT statement could not be prepared")
            
        }
        
        // 6
        sqlite3_finalize(queryStatement)
        tbl?.reloadData()
    }
    
    
    
    
    func questAlreadyExist(chalngId : Int? = nil,bioId : Int? = nil) {
         questId.removeAll()
        var queryStatement123: OpaquePointer? = nil
        let queryStatementString = "SELECT * FROM CharacterQuest WHERE challengeId = \(chalngId ?? 0) AND bioId = \(bioId ?? 0)"
        //DELETE FROM createCharacter WHERE projectid = 1;
        // let queryStatementString = "DELETE FROM Contact WHERE projectid = 2;"
        // 1
        if sqlite3_prepare_v2(db, queryStatementString, -2, &queryStatement123, nil) == SQLITE_OK {
            
            while(sqlite3_step(queryStatement123) == SQLITE_ROW){
                let id = sqlite3_column_int(queryStatement123, 0)
                print(id)
                questId.append(Int(id))
                print(questId)
                
                let queryResultCol1 = sqlite3_column_text(queryStatement123, 1)
                let queryResultCol2 = sqlite3_column_text(queryStatement123, 2)
                let queryResultCol3 = sqlite3_column_int(queryStatement123, 3)
                let queryResultCol4 = sqlite3_column_int(queryStatement123, 4)
                let queryResultCol5 = sqlite3_column_int(queryStatement123, 5)
                
                challengeId = Int(queryResultCol5)
                
                var questionString = String()
                if queryResultCol1 != nil{
                    questionString = String(cString: queryResultCol1!)
                }
                var answerString = String()
                if queryResultCol2 != nil{
                    answerString = String(cString: queryResultCol2!)
                }
                
            }
            
        } else {
            print("SELECT statement could not be prepared")
           
        }
        
        // 6
        sqlite3_finalize(queryStatement123)
    }
    
    
    
    
    func insert(saveDataArray:[questBioModel],challengId:Int?=nil,completion:@escaping(Bool)->()) {
         var isTrue = Bool()
         var insertCharacterQuestStatement: OpaquePointer? = nil
         var updateStatement: OpaquePointer? = nil
        
        if challengeId == challengId{
            
            for (index, name) in saveDataArray.enumerated() {
                
                  let updateStatementString = "UPDATE CharacterQuest SET Question = '\(name.quest ?? "")' ,Asnwer = '\(name.answer ?? "")', bioId = \(name.bioId ?? 0), projectid = 1 WHERE Id = \(questId[index]) AND bioId = \(name.bioId ?? 0) AND challengeId = \(name.challengeId ?? 0);"
               
                print(updateStatementString)
                
                if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
                    if sqlite3_step(updateStatement) == SQLITE_DONE {
                        print("Successfully inserted row.")
                        isTrue = true
                    } else {
                        print("Could not insert row.")
                        isTrue = false
                    }
                } else {
                    print("INSERT statement could not be prepared.")
                    isTrue = false
                }
                // 5
                sqlite3_finalize(updateStatement)
            }
            
           completion(isTrue)
        }
       else{
        
        let insertStatementString = "INSERT INTO CharacterQuest (Question, Asnwer, bioId, projectid, challengeId) VALUES (?, ?, ?, ?, ?);"
        // 1
        for (_, name) in saveDataArray.enumerated() {
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertCharacterQuestStatement, nil) == SQLITE_OK {
              
                let bioIntegr : Int = name.bioId ?? 0
                let projctInteger : Int = name.projId ?? 0
                let challengeInteger : Int = name.challengeId ?? 0
                // 3
                sqlite3_bind_text(insertCharacterQuestStatement, 1, name.quest, -1, nil)
                sqlite3_bind_text(insertCharacterQuestStatement, 2, name.answer, -1, nil)
                sqlite3_bind_int(insertCharacterQuestStatement, 3, Int32(bioIntegr))
                sqlite3_bind_int(insertCharacterQuestStatement, 4, Int32(projctInteger))
                sqlite3_bind_int(insertCharacterQuestStatement, 5, Int32(challengeInteger))
                
                // 4
                if sqlite3_step(insertCharacterQuestStatement) == SQLITE_DONE {
                    print("Successfully inserted row.")
                    isTrue = true
                } else {
                    print("Could not insert row.")
                    isTrue = false
                }
            } else {
                print("INSERT statement could not be prepared.")
                isTrue = false
            }
            // 5
            
            
            sqlite3_finalize(insertCharacterQuestStatement)
         }
            completion(isTrue)
        }
        
       
       // query123()
    }
    
    
    
    
    func insert(tfProjectName:UITextField,tfGenre:UITextField,tvPlotSummary:UITextView,completion:@escaping(Bool)->()) {
        var insertStatement: OpaquePointer? = nil
        let insertStatementString = "INSERT INTO Contact (projectName, genre, plotSummary) VALUES (?, ?, ?);"
        // 1
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let name: NSString = tfProjectName.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            let genre : NSString = tfGenre.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            let plot : NSString  = tvPlotSummary.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            
            // 2
           // sqlite3_bind_int(insertStatement, 1, id)
            // 3
            sqlite3_bind_text(insertStatement, 1, name.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, genre.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, plot.utf8String, -1, nil)
            
            // 4
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
        query { (status) in
            completion(true)
        }
        
    }
    
    
    
    
    func insertCreateCharacter(tfName:UITextField,tfAge:UITextField,lblGender:UILabel,tfprofession:UITextField,tfPOB:UITextField,tvCatchPhrase:IQTextView,tfTrait:UITextField,tfTrait1:UITextField,tfTrait2:UITextField,lblGuideType:UILabel,tfchildhood:IQTextView,tvDesired:IQTextView,tvDesired1:IQTextView,tvNotes:IQTextView,projectId:Int,completion:@escaping(Bool)->()) {
        var insertStatement: OpaquePointer? = nil
        
        let insertStatementString = "INSERT INTO createCharacter (username, age, gender, profession, placeofbirth, catchphrase, trait, trait1, trait2, guideType, defmoment, desire, desire1, notes, projectid) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
        // 1
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let userName: NSString = tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            let Age : NSString = tfAge.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            let gender : NSString  = lblGender.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            let profesion : NSString  = tfprofession.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            let POB : NSString  = tfPOB.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            let catchPhrase : NSString  = tvCatchPhrase.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            let trait : NSString  = tfTrait.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            let trait1 : NSString  = tfTrait1.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            let trait2 : NSString  = tfTrait2.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            let guideType : NSString  = lblGuideType.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            
             let childhood : NSString  = tfchildhood.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            
             let desired : NSString  = tvDesired.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            
             let desired1 : NSString  = tvDesired1.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            
            let notes : NSString  = tvNotes.text?.trimmingCharacters(in: .whitespacesAndNewlines) as NSString? ?? ""
            
            sqlite3_bind_text(insertStatement, 1, userName.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, Age.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, gender.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, profesion.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, POB.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, catchPhrase.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, trait.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, trait1.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, trait2.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 10, guideType.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 11, childhood.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 12, desired.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 13, desired1.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 14, notes.utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 15, Int32(projectId))
            
            // 4
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
        queryCreateCharacter(projectId: projectId) { (status) in
            completion(true)
        }
    }
    
    
    func createCharacterUpdateQuery(tfName:UITextField,tfAge:UITextField,lblGender:UILabel,tfprofession:UITextField,tfPOB:UITextField,tvCatchPhrase:IQTextView,tfTrait:UITextField,tfTrait1:UITextField,tfTrait2:UITextField,lblGuideType:UILabel,tfchildhood:IQTextView,tvDesired:IQTextView,tvDesired1:IQTextView,tvNotes:IQTextView,projectId:Int,ID:Int,completion:@escaping(Bool)->()){
        var isTrue = Bool()
        print(ID)
        
        var createCharacterUpdateStatement: OpaquePointer? = nil
        let updateStatementString = "UPDATE createCharacter SET username = '\(tfName.text ?? "")', age = '\(tfAge.text ?? "")', gender = '\(lblGender.text ?? "")', profession = '\(tfprofession.text ?? "")', placeofbirth = '\(tfPOB.text ?? "")', catchphrase = '\(tvCatchPhrase.text ?? "")', trait = '\(tfTrait.text ?? "")', trait1 = '\(tfTrait1.text ?? "")', trait2 = '\(tfTrait2.text ?? "")', guideType = '\(lblGuideType.text ?? "")', defmoment = '\(tfchildhood.text ?? "")', desire = '\(tvDesired.text ?? "")', desire1 = '\(tvDesired1.text ?? "")', notes = '\(tvNotes.text ?? "")', projectid = \(projectId) WHERE Id = \(ID);"
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &createCharacterUpdateStatement, nil) == SQLITE_OK {
            if sqlite3_step(createCharacterUpdateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
                isTrue = true
            } else {
                print("Could not update row.")
                isTrue = false
            }
        } else {
            print("UPDATE statement could not be prepared")
            isTrue = false
        }
        sqlite3_finalize(createCharacterUpdateStatement)
        completion(isTrue)
    }
    
    
    
    func query(tbl:UITableView? = nil,completion:@escaping(Bool)->()) {
        projectListArray.removeAll()
        var queryStatement: OpaquePointer?
       let queryStatementString = "SELECT * FROM Contact"
        //DELETE FROM createCharacter WHERE projectid = 1;
       // let queryStatementString = "DELETE FROM Contact WHERE projectid = 2;"
        // 1
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
  
                while(sqlite3_step(queryStatement) == SQLITE_ROW){
                    let id = sqlite3_column_int(queryStatement, 0)
                    let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
                    let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
                    let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
                    
                     var projectName = String()
                    if queryResultCol1 != nil{
                        projectName = String(cString: queryResultCol1!)
                    }
                     var genre = String()
                    if queryResultCol2 != nil{
                        genre = String(cString: queryResultCol2!)
                    }
                     var plotSummary = String()
                    if queryResultCol3 != nil{
                        plotSummary = String(cString: queryResultCol3!)
                    }
                      // 5
                    print("Query Result:")
                    projectListArray.append(AddProjectModel(projectId: Int(id), projectName: projectName, genre: genre, plotSummary: plotSummary))
                }
            completion(true)
        } else {
            print("SELECT statement could not be prepared")
            completion(false)
        }
        
        // 6
        sqlite3_finalize(queryStatement)
    }
    
    func titleProject(index:Int){
        titleNavigtionName = projectListArray[index].projectName ?? ""
    }
    
    
    func showquery(tbl:UITableView? = nil,projectid : Int,completion:@escaping(Bool)->()) {
        projectListArray.removeAll()
        var queryStatement: OpaquePointer?
        let queryStatementString = "SELECT * FROM Contact WHERE projectid = \(projectid)"
        //DELETE FROM createCharacter WHERE projectid = 1;
        // let queryStatementString = "DELETE FROM Contact WHERE projectid = 2;"
        // 1
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while(sqlite3_step(queryStatement) == SQLITE_ROW){
                let id = sqlite3_column_int(queryStatement, 0)
                let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
                let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
                let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
                
                var projectName = String()
                if queryResultCol1 != nil{
                    projectName = String(cString: queryResultCol1!)
                }
                var genre = String()
                if queryResultCol2 != nil{
                    genre = String(cString: queryResultCol2!)
                }
                var plotSummary = String()
                if queryResultCol3 != nil{
                    plotSummary = String(cString: queryResultCol3!)
                }
                // 5
                print("Query Result:")
                projectListArray.append(AddProjectModel(projectId: Int(id), projectName: projectName, genre: genre, plotSummary: plotSummary))
            }
            completion(true)
        } else {
            print("SELECT statement could not be prepared")
            completion(false)
        }
        
        // 6
        sqlite3_finalize(queryStatement)
    }
    
    
    
    
    func addProjectUpdateQuery(tfProjectName:UITextField,tfGenre:UITextField,tvPlotSummary:UITextView,projectId:Int,completion:@escaping(Bool)->()){
        var isTrue = Bool()
        var addProjectUpdateStatement: OpaquePointer? = nil
        let updateStatementString = "UPDATE Contact SET projectName = '\(tfProjectName.text ?? "")', genre = '\(tfGenre.text ?? "")', plotSummary = '\(tvPlotSummary.text ?? "")' WHERE projectid = \(projectId);"
        if sqlite3_prepare_v2(db, updateStatementString, -1, &addProjectUpdateStatement, nil) == SQLITE_OK {
            if sqlite3_step(addProjectUpdateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
                isTrue = true
            } else {
                print("Could not update row.")
                isTrue = false
            }
        } else {
            print("UPDATE statement could not be prepared")
            isTrue = false
        }
        sqlite3_finalize(addProjectUpdateStatement)
        completion(isTrue)
    }
    
    func addProjectDeleteQuery(projectId:Int,completion:@escaping(Bool)->()){
        var isTrue = Bool()
        var addProjectUpdateStatement: OpaquePointer? = nil
        let updateStatementString = "DELETE FROM Contact WHERE projectid = \(projectId);"
        if sqlite3_prepare_v2(db, updateStatementString, -1, &addProjectUpdateStatement, nil) == SQLITE_OK {
            if sqlite3_step(addProjectUpdateStatement) == SQLITE_DONE {
                print("Successfully delete row.")
                isTrue = true
            } else {
                print("Could not delete row.")
                isTrue = false
            }
        } else {
            print("delete statement could not be prepared")
            isTrue = false
        }
        sqlite3_finalize(addProjectUpdateStatement)
        completion(isTrue)
    }
    
    
    
    func queryCreateCharacter(tbl:UITableView? = nil,projectId:Int,completion:@escaping(Bool)->()) {
        createCharacterArray.removeAll()
        var queryStatement: OpaquePointer?
        //"DELETE FROM createCharacter WHERE projectid = 1;"
       // SELECT * FROM createCharacter;
        
        let queryStatementString = "SELECT * FROM createCharacter WHERE projectid=\(projectId)"
        // 1
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
               while(sqlite3_step(queryStatement) == SQLITE_ROW){
                    let id = sqlite3_column_int(queryStatement, 0)
                    let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
                    let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
                    let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
                    let queryResultCol4 = sqlite3_column_text(queryStatement, 4)
                    let queryResultCol5 = sqlite3_column_text(queryStatement, 5)
                    let queryResultCol6 = sqlite3_column_text(queryStatement, 6)
                    let queryResultCol7 = sqlite3_column_text(queryStatement, 7)
                    let queryResultCol8 = sqlite3_column_text(queryStatement, 8)
                    let queryResultCol9 = sqlite3_column_text(queryStatement, 9)
                    let queryResultCol10 = sqlite3_column_text(queryStatement, 10)
                    let queryResultCol11 = sqlite3_column_text(queryStatement, 11)
                    let queryResultCol12 = sqlite3_column_text(queryStatement, 12)
                    let queryResultCol13 = sqlite3_column_text(queryStatement, 13)
                    let queryResultCol14 = sqlite3_column_text(queryStatement, 14)
                    let queryResultCol15 = sqlite3_column_int(queryStatement, 15)
                
                    //   let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
                var username = String()
                if queryResultCol1 != nil{
                  username = String(cString: queryResultCol1!)
                }
                var age = String()
                if queryResultCol2 != nil{
                    age = String(cString: queryResultCol2!)
                }
                var gender = String()
                if queryResultCol3 != nil{
                    gender = String(cString: queryResultCol3!)
                }
                var profession = String()
                if queryResultCol4 != nil{
                    profession = String(cString: queryResultCol4!)
                }
                var placeofbirth = String()
                if queryResultCol5 != nil{
                    placeofbirth = String(cString: queryResultCol5!)
                }
                var catchphrase = String()
                if queryResultCol6 != nil{
                    catchphrase = String(cString: queryResultCol6!)
                }
                var trait = String()
                if queryResultCol7 != nil{
                    trait = String(cString: queryResultCol7!)
                }
                var trait1 = String()
                if queryResultCol8 != nil{
                    trait1 = String(cString: queryResultCol8!)
                }
                var trait2 = String()
                if queryResultCol9 != nil{
                    trait2 = String(cString: queryResultCol9!)
                }
                var guideType = String()
                if queryResultCol10 != nil{
                    guideType = String(cString: queryResultCol10!)
                }
                var defmoment = String()
                if queryResultCol11 != nil{
                    defmoment = String(cString: queryResultCol11!)
                }
                var desire = String()
                if queryResultCol12 != nil{
                    desire = String(cString: queryResultCol12!)
                }
                var desire1 = String()
                if queryResultCol13 != nil{
                    desire1 = String(cString: queryResultCol13!)
                }
                var notes = String()
                if queryResultCol14 != nil{
                    notes = String(cString: queryResultCol14!)
                }
                var projectId = Int()
                projectId = Int(queryResultCol15)
                
                createCharacterArray.append(AddCreateCharacterModel(id: Int(id), username: username, age: age, gender: gender, profession: profession, placeofbirth: placeofbirth, catchphrase: catchphrase, trait: trait, trait1: trait1, trait2: trait2, guideType: guideType, defmoment: defmoment, desire: desire, desire1: desire1, notes: notes, projectId: projectId))
                }
            
                completion(true)
            
        } else {
            print("SELECT statement could not be prepared")
            completion(false)
        }
        
        // 6
        sqlite3_finalize(queryStatement)
    }
    
    
    func ShowqueryCreateCharacter(tbl:UITableView? = nil,createCharacterId:Int,completion:@escaping(Bool)->()) {
        createCharacterArray.removeAll()
        var EditQueryStatement: OpaquePointer?
        //"DELETE FROM createCharacter WHERE projectid = 1;"
        // SELECT * FROM createCharacter;
        
        let queryStatementString = "SELECT * FROM createCharacter WHERE Id=\(createCharacterId)"
        // 1
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &EditQueryStatement, nil) == SQLITE_OK {
            
            while(sqlite3_step(EditQueryStatement) == SQLITE_ROW){
                let id = sqlite3_column_int(EditQueryStatement, 0)
                let queryResultCol1 = sqlite3_column_text(EditQueryStatement, 1)
                let queryResultCol2 = sqlite3_column_text(EditQueryStatement, 2)
                let queryResultCol3 = sqlite3_column_text(EditQueryStatement, 3)
                let queryResultCol4 = sqlite3_column_text(EditQueryStatement, 4)
                let queryResultCol5 = sqlite3_column_text(EditQueryStatement, 5)
                let queryResultCol6 = sqlite3_column_text(EditQueryStatement, 6)
                let queryResultCol7 = sqlite3_column_text(EditQueryStatement, 7)
                let queryResultCol8 = sqlite3_column_text(EditQueryStatement, 8)
                let queryResultCol9 = sqlite3_column_text(EditQueryStatement, 9)
                let queryResultCol10 = sqlite3_column_text(EditQueryStatement, 10)
                let queryResultCol11 = sqlite3_column_text(EditQueryStatement, 11)
                let queryResultCol12 = sqlite3_column_text(EditQueryStatement, 12)
                let queryResultCol13 = sqlite3_column_text(EditQueryStatement, 13)
                let queryResultCol14 = sqlite3_column_text(EditQueryStatement, 14)
                let queryResultCol15 = sqlite3_column_int(EditQueryStatement, 15)
                
                //   let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
                var username = String()
                if queryResultCol1 != nil{
                    username = String(cString: queryResultCol1!)
                }
                var age = String()
                if queryResultCol2 != nil{
                    age = String(cString: queryResultCol2!)
                }
                var gender = String()
                if queryResultCol3 != nil{
                    gender = String(cString: queryResultCol3!)
                }
                var profession = String()
                if queryResultCol4 != nil{
                    profession = String(cString: queryResultCol4!)
                }
                var placeofbirth = String()
                if queryResultCol5 != nil{
                    placeofbirth = String(cString: queryResultCol5!)
                }
                var catchphrase = String()
                if queryResultCol6 != nil{
                    catchphrase = String(cString: queryResultCol6!)
                }
                var trait = String()
                if queryResultCol7 != nil{
                    trait = String(cString: queryResultCol7!)
                }
                var trait1 = String()
                if queryResultCol8 != nil{
                    trait1 = String(cString: queryResultCol8!)
                }
                var trait2 = String()
                if queryResultCol9 != nil{
                    trait2 = String(cString: queryResultCol9!)
                }
                var guideType = String()
                if queryResultCol10 != nil{
                    guideType = String(cString: queryResultCol10!)
                }
                var defmoment = String()
                if queryResultCol11 != nil{
                    defmoment = String(cString: queryResultCol11!)
                }
                var desire = String()
                if queryResultCol12 != nil{
                    desire = String(cString: queryResultCol12!)
                }
                var desire1 = String()
                if queryResultCol13 != nil{
                    desire1 = String(cString: queryResultCol13!)
                }
                var notes = String()
                if queryResultCol14 != nil{
                    notes = String(cString: queryResultCol14!)
                }
                var projectId = Int()
                projectId = Int(queryResultCol15)
                
                createCharacterArray.append(AddCreateCharacterModel(id: Int(id), username: username, age: age, gender: gender, profession: profession, placeofbirth: placeofbirth, catchphrase: catchphrase, trait: trait, trait1: trait1, trait2: trait2, guideType: guideType, defmoment: defmoment, desire: desire, desire1: desire1, notes: notes, projectId: projectId))
            }
            
            completion(true)
            
        } else {
            print("SELECT statement could not be prepared")
            completion(false)
        }
        
        // 6
        sqlite3_finalize(EditQueryStatement)
    }
    
    func createCharacterDeleteQuery(createCharacterId:Int,completion:@escaping(Bool)->()){
        var isTrue = Bool()
        var createCharacterDeleteStatement: OpaquePointer? = nil
        let updateStatementString = "DELETE FROM createCharacter WHERE Id = \(createCharacterId);"
        if sqlite3_prepare_v2(db, updateStatementString, -1, &createCharacterDeleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(createCharacterDeleteStatement) == SQLITE_DONE {
                print("Successfully delete row.")
                isTrue = true
            } else {
                print("Could not delete row.")
                isTrue = false
            }
        } else {
            print("delete statement could not be prepared")
            isTrue = false
        }
        sqlite3_finalize(createCharacterDeleteStatement)
        completion(isTrue)
    }
    
    

}
