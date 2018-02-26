//
//  FeedViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Firebase
import Toucan

class FeedViewController: UIViewController {
    
    let feedView = FeedView()
    private var authService = AuthUserService()
    
    private var posts = [Post](){
        didSet {
            DispatchQueue.main.async {
                self.feedView.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        feedView.tableView.delegate = self
        feedView.tableView.dataSource = self
        view.addSubview(feedView)
        configureNavBar()
        
        authService.delegate = self
        
        let edgePanRight = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwipedRight))
        edgePanRight.edges = .right
        view.addGestureRecognizer(edgePanRight)
    }
    
    private func loadAllPosts() {
        DBService.manager.loadAllPosts { (posts) in
            if let posts = posts {
                self.posts = posts
            } else {
                print("error loading posts")
            }
        }
    }
    
    @objc private func logout() {
        let alertView = UIAlertController(title: "Are you sure you want to Logout?", message: nil, preferredStyle: .alert)
        let yesOption = UIAlertAction(title: "Yes", style: .destructive) { (alertAction) in
            self.authService.signOut()
            
        }
        let noOption = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertView.addAction(yesOption)
        alertView.addAction(noOption)
        present(alertView, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //MARK: checks if user is signed in or not
        if AuthUserService.getCurrentUser() == nil {
            let loginVC = LoginViewController()
            self.present(loginVC, animated: false, completion: nil)
        } else {
            loadAllPosts()
        }
    }
    
    private func configureNavBar() {
        self.navigationItem.title = "Feed"
        let logoutBarItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = logoutBarItem
        //navigationController?.hidesBarsOnSwipe = true
    }
    
}

extension FeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if posts.count > 0 {
            feedView.tableView.backgroundView = nil
            feedView.tableView.separatorStyle = .singleLine
            numOfSections = 1
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: feedView.tableView.bounds.size.width, height: feedView.tableView.bounds.size.height))
            noDataLabel.text = "No Posts Yet"
            noDataLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
            noDataLabel.textAlignment = .center
            feedView.tableView.backgroundView = noDataLabel
            feedView.tableView.separatorStyle = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedView.tableView.dequeueReusableCell(withIdentifier: "Post Cell", for: indexPath) as! FeedTableViewCell
        let post = posts.reversed()[indexPath.row]
//        cell.delegate = self
        cell.currentIndexPath = indexPath
        cell.tag = indexPath.row
        cell.configurePostCell(post: post)
        return cell
    }

}

//extension FeedViewController: UITableViewDelegate {
//
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return UIScreen.main.bounds.height * 4/5
////    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//
//}

// MARK: Sign Out
extension FeedViewController: AuthUserServiceDelegate {
    func didSignOut(_ userService: AuthUserService) {
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true) {
            let tabBarController: UITabBarController = self.tabBarController! as UITabBarController
            tabBarController.selectedIndex = 0
        }
    }
    func didFailSigningOut(_ userService: AuthUserService, error: Error) {
        
    }
}

extension FeedViewController: UIGestureRecognizerDelegate {

    @objc func screenEdgeSwipedRight(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            tabBarController?.selectedIndex = 1
            print("Screen edge swiped right!")
        }
    }
}
