//
//  DetailViewController.swift
//  Flowers
//
//  Created by Jacques Micheli on 08/11/2020.
//  Copyright © 2020 byrdland. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var more: UILabel!
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    var placeName: String?
    var placeInfo: String?
    var placeMore: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        city.text = placeName
        info.text = placeInfo
        more.text = placeMore
        
        let swipeRight = UISwipeGestureRecognizer(target: self,action:#selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            self.navigationController?.popViewController(animated: true)
        }
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
