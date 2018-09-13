//
//  MeteoViewController.swift
//  Projet 9
//
//  Created by Amg on 23/08/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class MeteoViewController: UIViewController {
    
    
    @IBOutlet weak var countrySearchBar: UISearchBar!
    @IBOutlet weak var CountryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//extension MeteoViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//}
