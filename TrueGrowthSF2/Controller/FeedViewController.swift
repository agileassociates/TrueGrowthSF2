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

protocol FeedViewCellDelegate {
    func didTapLikeButton(title: String)
}

class FeedViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
}


class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //var ref: DatabaseReference!
    var posts = [Post]()
    var likes = [Like]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser == nil {
            
            let loginVC = LoginViewController()
            present(loginVC, animated: true, completion: {
            })
        }
        progressView.isHidden = true
        progressView.progress = 0.0
        tableView.dataSource = self
        print("start of view controller\n\n\n\n\n")
        //loadLikeKeys()
        loadPosts()
        loadLikes()
        print("end of view controller")

    }
    
    func loadLikeKeys() {
        let likesRef = Database.database().reference(withPath: "likes")
        print("This is LikeKeys func:       \n\n\n\n\n\n\n\n\n")
        //print("this is the acutal LikeKeys:  ", likesRef.uid)
        print("\n\n\n\n\n\n\n\n\nGoodbye........\n\n\n\n\n\n\n\n\n")
    }
    
    func loadPosts() {
        Database.database().reference().child("posts").observe(.childAdded, with: { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                //print(dict)
                let captionText = dict["caption"] as! String
                let photoUrlText = dict["photoUrl"] as! String
                let emailText = dict["email"] as! String
                let post = Post(captionString: captionText, photoUrlString: photoUrlText, emailString: emailText)
                self.posts.append(post)
                print(self.posts.description)
                self.tableView.reloadData()
            }
        })
    }
    
    func loadLikes() {
        Database.database().reference().child("likes").observe(.childAdded, with: { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                //print(dict)
                let uid = dict["uid"] as! String
                let photoUrlText = dict["photoUrl"] as! String
                let uuid = dict["UUID"] as! String
                let like = Like(photoId: photoUrlText, userId: uid, userUid: uuid)
                self.likes.append(like)
                print("\n\n\n\n\n",self.likes)
                self.tableView.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension FeedViewController: UITableViewDataSource {
    
    @IBAction func likedBtnPressed(_ sender: UIButton) {
        
        var superview = sender.superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view.superview
        }
        guard let cell = superview as? UITableViewCell else {
            print("button is not contained in a table view cell")
            return
        }
        guard let indexPath = tableView.indexPath(for: cell) else {
            print("failed to get index path for cell containing button")
            return
        }
        
        let currentUser = Auth.auth().currentUser
        let ref = Database.database().reference()
        let postsReference = ref.child("likes")
        let newPostId = postsReference.childByAutoId().key
        let newPostReference = postsReference.child(newPostId!)
        var count = 0
        for like in self.likes {
            if like.photoUrl == self.posts[indexPath.row].photoUrl && like.uid == self.likes[count].uid {
                print("\n\n\n\n\n\n\n ****THIS IS THE SAME**** ****THIS IS THE SAME****" )
                sender.setImage(UIImage(named: "Like"), for: UIControl.State.normal)

                let key = like.uuid
                let reference = ref.child("likes").child(key)
                reference.removeValue { error, _ in
                    print(error?.localizedDescription)
                }
                likes.remove(at: count)
                return
            }
            count += 1
        }
        
        newPostReference.setValue(["uid": currentUser?.uid, "photoUrl": self.posts[indexPath.row].photoUrl, "UUID": newPostReference.key], withCompletionBlock: {
            (error, ref) in
            if error != nil {
                print("error")
                return
            }
            print("success")
            print(currentUser?.uid)
            print(self.posts[indexPath.row].photoUrl)
            // cell.likedImageView.image = UIImage(named: "yellow_like")
            //cell.likeButton.image = UIImage(named: "yellow_like")
            sender.setImage(UIImage(named: "did _like"), for: UIControl.State.normal)
            self.tableView.reloadData()
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedViewCell
        cell.emailLabel?.text = posts[indexPath.row].email
        //cell.emailCellLabel?.text =
        //cell.photoImageView?.image = UIImage(named: "bobby")
        let photoImage = posts[indexPath.row].photoUrl
        let url = NSURL(string: photoImage)
        URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error)
                    return
                }
            DispatchQueue.main.async {
                cell.photoImageView?.image = UIImage(data: data!)
            }
            
            }).resume()
        
//        cell.likedImageView.tag = indexPath.row
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//        cell.likedImageView.isUserInteractionEnabled = true
//        cell.likedImageView.addGestureRecognizer(tapGestureRecognizer)
//
        return cell
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        // Your action
        print("hi")
        let touch = tapGestureRecognizer.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: touch) {
            // Access the image or the cell at this index path
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedViewCell

            
//            let image = UIImage(named: "yellow_like")?.withRenderingMode(.alwaysTemplate)
//            cell.likedImageView.tintColor = .yellow
//            cell.likedImageView.image = image
//            print("******THIS IS YELLOW ****************THIS IS YELLOW")
//
            let currentUser = Auth.auth().currentUser
            let ref = Database.database().reference()
            let postsReference = ref.child("likes")
            let newPostId = postsReference.childByAutoId().key
            let newPostReference = postsReference.child(newPostId!)
            var count = 0
            for like in self.likes {

                if like.photoUrl == self.posts[indexPath.row].photoUrl && like.uid == self.likes[count].uid {
                print("\n\n\n\n\n\n\n ****THIS IS THE SAME**** ****THIS IS THE SAME****" )
                    let key = like.uuid
                    let reference = ref.child("likes").child(key)
                    reference.removeValue { error, _ in
                        print(error?.localizedDescription)
                    }
                    likes.remove(at: count)
                    return
                }
                count += 1
            }
            newPostReference.setValue(["uid": currentUser?.uid, "photoUrl": self.posts[indexPath.row].photoUrl, "UUID": newPostReference.key], withCompletionBlock: {
                        (error, ref) in
                            if error != nil {
                                print("error")
                                return
                        }
                        print("success")
                        print(currentUser?.uid)
                        print(self.posts[indexPath.row].photoUrl)
                       // cell.likedImageView.image = UIImage(named: "yellow_like")
                self.tableView.reloadData()

            })
        }
    }
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension UIImage {
    static func localImage(_ name: String, template: Bool = false) -> UIImage {
        var image = UIImage(named: name)!
        if template {
            image = image.withRenderingMode(.alwaysTemplate)
        }
        return image
    }
}
    
    

