//
//  MemeDetailViewController.swift
//  Mememe
//
//  Created by tiago turibio on 15/06/18.
//  Copyright © 2018 tiago turibio. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var statusBarShouldBeHidden = false
    
    @IBOutlet weak var memeImageView: UIImageView!
    var meme: Meme?{
        didSet{
            updateUI(meme)
        }
    }
    
    @IBAction func presentModaly(_ sender: Any) {
        // Instantiate the modal view controller from storyboard
        let memeViewController = storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        
        memeViewController.meme = meme
        
        // Hide the status bar
        statusBarShouldBeHidden = true
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        // Present the modal view controller
        present(memeViewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarShouldBeHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var prefersStatusBarHidden: Bool{
        return statusBarShouldBeHidden
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(meme)
        NotificationCenter.default.addObserver(self, selector: #selector(self.memeUpdated(notification:)), name: NSNotification.Name(rawValue: NotificationCenterStrings.memeWasUpated.rawValue), object: nil)
    }
    
    fileprivate func updateUI(_ meme: Meme?){
        DispatchQueue.main.async { [weak self] in
         self?.memeImageView?.image = meme?.memeImage
        }
    }
    
    @objc fileprivate func memeUpdated(notification: Notification?){
        if let updatedMeme = notification?.object as? Meme{
         meme = updatedMeme
        }
    }
    
}
