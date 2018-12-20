//
//  ViewController.swift
//  TrueGrowthSF2
//
//  Created by Johny Babylon on 12/18/18.
//  Copyright © 2018 Agile Associates. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var contactsTableView: UITableView!
    
    var contacts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        contactsTableView.dataSource = self
        
        contacts = ["bobby", "brian", "eric", "glen", "jamal", "monroe", "rachel", "tom", "zoe" ]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = contacts[indexPath.row]
        cell.imageView?.image = UIImage(named: contacts[indexPath.row])
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */



}

