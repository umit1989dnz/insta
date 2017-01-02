//
//  infoViewController.swift
//  insta
//
//  Created by omid on 12/30/16.
//  Copyright © 2016 omid pourpanah. All rights reserved.
//

import UIKit

class infoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(infoViewController.dissmis(gesture:)))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(infoViewController.share(gesture:)))
        swipeDown.direction = .down
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeDown)
    }

    func dissmis(gesture:UISwipeGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
        
    }
    func share (gesture: UISwipeGestureRecognizer)  {
        let share = UIActivityViewController(activityItems: [], applicationActivities: nil)
        self.present(share, animated: true, completion: nil)
    }

}
