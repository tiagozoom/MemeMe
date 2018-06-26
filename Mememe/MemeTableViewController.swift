//
//  MemeTableViewController.swift
//  Mememe
//
//  Created by tiago turibio on 06/06/18.
//  Copyright © 2018 tiago turibio. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController{
    
    var statusBarShouldBeHidden = false

    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }

    @IBAction func presentModaly(_ sender: Any) {
        // Instantiate the modal view controller from storyboard
        let memeViewController = storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        
        // Hide the status bar
        statusBarShouldBeHidden = true
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        // Present the modal view controller
        present(memeViewController, animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool{
        return statusBarShouldBeHidden
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarShouldBeHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemeTableViewCell.ID, for: indexPath) as! MemeTableViewCell
        cell.meme = memes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var meme = memes[indexPath.row]
        meme.index = indexPath.row
        openDetailView(meme)
    }
    
    fileprivate func openDetailView(_ meme: Meme){
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! MemeDetailViewController
        detailViewController.meme = meme
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            (UIApplication.shared.delegate as! AppDelegate).memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
