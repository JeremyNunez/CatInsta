//
//  ViewController.swift
//  instacat
//
//  Created by Jeremi Nunez on 11/19/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController, UICollectionViewDataSource{
    
    
    
    @IBOutlet weak var loginButton: UIBarButtonItem!
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    @IBOutlet weak var loginInfoLabel: UILabel!
    
    @IBOutlet weak var imageCollection: UICollectionView!
    var customImageFlowLayout: CustomImageFlowLayout!
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImages()
        
        customImageFlowLayout = CustomImageFlowLayout()
        imageCollection.collectionViewLayout = customImageFlowLayout
        imageCollection.backgroundColor = .white
        
    }
    func loadImages(){
        images.append(UIImage(named: "image1")!)
        images.append(UIImage(named: "image1")!)
        images.append(UIImage(named: "image1")!)
        images.append(UIImage(named: "image1")!)
        images.append(UIImage(named: "image1")!)
        images.append(UIImage(named: "image1")!)
        self.imageCollection.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            self.loginButton.isEnabled = false
            self.logoutButton.isEnabled = true
            self.loginInfoLabel.text = "Hello  " + (Auth.auth().currentUser?.email)!
        }else{
            self.loginButton.isEnabled = true
            self.logoutButton.isEnabled = false
            self.loginInfoLabel.text = "Hello please login"
        }
    }

    @IBAction func logoutButtonClicked(_ sender: Any) {
        if Auth.auth().currentUser != nil{
            do{
                try Auth.auth().signOut()
                self.loginButton.isEnabled = true
                self.logoutButton.isEnabled = false
                self.loginInfoLabel.text = "Hello please login"
            } catch let signOutError as NSError{
                print("Error signing out : %@", signOutError)
            }
        }
    }
    func collectionView(_ imageCollection: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ imageCollection: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        let image = images[indexPath.row]
        cell.imageView.image = image;
        return cell
    }
}
