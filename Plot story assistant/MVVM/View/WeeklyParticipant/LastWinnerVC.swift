//
//  LastWinnerVC.swift
//  Plot story assistant
//
//  Created by webastral on 27/06/19.
//  Copyright © 2019 webastral. All rights reserved.
//

import UIKit

class LastWinnerVC: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tableVew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableVew.dataSource = self
        tableVew.delegate = self
        
        WeeklychallengeViewModel.shared().weeklyLastWinnerChallenge(topView: self, tblView: tableVew)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return WeeklychallengeViewModel.shared().cellForRowAtIndexLastWinner(tableView: tableView, indexPath: indexPath, topView: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WeeklychallengeViewModel.shared().getHeightWeekly(indexPath:indexPath)
    }
    

}
