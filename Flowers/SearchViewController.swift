//
//  SearchViewController.swift
//  Flowers
//
//  Created by Jacques Micheli on 05/09/2020.
//  Copyright © 2020 byrdland. All rights reserved.
//
import UIKit
import Pulley

class SearchViewController: UITableViewController, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate var drawerBottomSafeArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
            
            // We'll configure our UI to respect the safe area. In our small demo app, we just want to adjust the contentInset for the tableview.
            
            /* For now ...
            tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: drawerBottomSafeArea, right: 0.0)
             */
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        // Do any additional setup after loading the view.
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Candies"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        self.searchController.searchBar.delegate = self; // Important !
        // self.navigationController?.isNavigationBarHidden = true
        pulleyViewController?.delegate = self

        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //enter your search code
        print ("click search")
        pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //enter your search code
        print ("click cancel")
        pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("search bar delegate did begin editing")
        pulleyViewController?.setDrawerPosition(position: .open, animated: true)
    }
}


extension SearchViewController: PulleyDrawerViewControllerDelegate {

       func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
       {
           // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
           print("collapsedDrawerHeight")
           
           return 68.0 + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
           
       }
       
       func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
       {
           // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
        print("partialRevealDrawerHeight")
           return 264.0 + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
       }
       
       func supportedDrawerPositions() -> [PulleyPosition] {
            print("supportedDrawerPositions")
           return PulleyPosition.all // You can specify the drawer positions you support. This is the same as: [.open, .partiallyRevealed, .collapsed, .closed]
       }
       
       // This function is called by Pulley anytime the size, drawer position, etc. changes. It's best to customize your VC UI based on the bottomSafeArea here (if needed). Note: You might also find the `pulleySafeAreaInsets` property on Pulley useful to get Pulley's current safe area insets in a backwards compatible (with iOS < 11) way. If you need this information for use in your layout, you can also access it directly by using `drawerDistanceFromBottom` at any time.
       func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat)
       {
           // We want to know about the safe area to customize our UI. Our UI customization logic is in the didSet for this variable.
           
        
        print("drawerPositionDidChange")
        
        drawerBottomSafeArea = bottomSafeArea
           
       /*
        Some explanation for what is happening here:
        1. Our drawer UI needs some customization to look 'correct' on devices like the iPhone X, with a bottom safe area inset.
        2. We only need this when it's in the 'collapsed' position, so we'll add some safe area when it's collapsed and remove it when it's not.
        3. These changes are captured in an animation block (when necessary) by Pulley, so these changes will be animated along-side the drawer automatically.
        */
    
    
        /* For noow ...
         
       if drawer.drawerPosition == .collapsed
       {
           headerSectionHeightConstraint.constant = 68.0 + drawerBottomSafeArea
       }
       else
       {
           headerSectionHeightConstraint.constant = 68.0
       }
       
       
       // Handle tableview scrolling / searchbar editing
       
       tableView.isScrollEnabled = drawer.drawerPosition == .open || drawer.currentDisplayMode == .panel
       
       */
       /*
       if drawer.drawerPosition != .open
       {
           searchBar.resignFirstResponder()
       }
       */
       /*
       
       if drawer.currentDisplayMode == .panel
       {
           topSeparatorView.isHidden = drawer.drawerPosition == .collapsed
           bottomSeperatorView.isHidden = drawer.drawerPosition == .collapsed
       }
       else
       {
           topSeparatorView.isHidden = false
           bottomSeperatorView.isHidden = true
       }
        */
   }
}




extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
    print("updating")
    // pulleyViewController?.setDrawerPosition(position: .open, animated: true)
  }
}
