//
//  DetailViewController.swift
//  Github Viewer
//
//  Created by Matheus Franceschini on 07/02/25.
//

import Foundation
import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    var repositories: [Repository] = []
    var userLogin: String?
    var userAvatarURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureTableView()
    }
    
    func configureLayout() {
        profileImageView.backgroundColor = .blue
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        
        usernameLabel.text = userLogin
        
        if let userAvatarURL = userAvatarURL, let url = URL(string: userAvatarURL) {
            profileImageView.kf.setImage(with: url)
        }
    }
    
    func configureTableView() {
        repositoriesTableView.dataSource = self
        repositoriesTableView.delegate = self
        repositoriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = repositories[indexPath.row].name
        content.secondaryText = repositories[indexPath.row].language
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
