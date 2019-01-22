//
//  FirstViewController.swift
//  TrueGrowthSF2
//
//  Created by Johny Babylon on 12/18/18.
//  Copyright © 2018 Agile Associates. All rights reserved.
//

import UIKit
import MobileCoreServices
import Firebase

class FeedViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
}


class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //var ref: DatabaseReference!
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.isHidden = true
        progressView.progress = 0.0
        tableView.dataSource = self
        loadPosts()
        

    }
    
    func loadPosts() {
        Database.database().reference().child("posts").observe(.childAdded, with: { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                //print(dict)
                let captionText = dict["caption"] as! String
                let photoUrlText = dict["photoUrl"] as! String
                let post = Post(captionString: captionText, photoUrlString: photoUrlText)
                self.posts.append(post)
                print(self.posts)
                self.tableView.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedViewCell
        cell.emailLabel?.text = posts[indexPath.row].caption
        //cell.emailCellLabel?.text = 
        return cell
    }
    
}
    
    

