//
//  DrawerContentViewController.swift
//  Flowers
//
//  Created by Jacques Micheli on 05/09/2020.
//  Copyright © 2020 byrdland. All rights reserved.
//

import UIKit
import Pulley

class DrawerContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let contents = [
    "1etplus", "2", "3", "4", "5", "6", "7", "8", "1", "2", "3", "4", "5", "6", "7", "8", "1", "2", "3", "4", "5", "6", "7", "8"]
    var filteredContents: [String] = []
    // let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("navigation item is \(navigationItem)")
        // self.tableView.dataSource = self // mandatory ! => In storyBoard !
        // self.tableView.delegate = self // mandatory ! => In storyBoard !
        let swipeRight = UISwipeGestureRecognizer(target: self,action:#selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
        }
    }
    
    var isSearchBarEmpty: Bool {
      return searchBar.text?.isEmpty ?? true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    fileprivate var drawerBottomSafeArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
            
            // We'll configure our UI to respect the safe area. In our small demo app, we just want to adjust the contentInset for the tableview.
            
            /* For now ...
            tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: drawerBottomSafeArea, right: 0.0)
             */
        }
    }
    
    // MARK: - Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableview 1")
        if isSearchBarEmpty {
            return contents.count
        } else {
            return filteredContents.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableview 2")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCell
        if isSearchBarEmpty {
            cell.label1.text = contents[ indexPath.row ]
        } else {
            cell.label1.text = filteredContents[ indexPath.row ]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
        let mycell = tableView.cellForRow(at: indexPath) as! MyCell
        if let content = mycell.label1.text {
            print("cell content is \(content)")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            let contentOffset = scrollView.contentOffset.y
            print("contentOffset: ", contentOffset)
            searchBar.resignFirstResponder()
        }
    }

}

extension DrawerContentViewController: PulleyDrawerViewControllerDelegate {

   func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
   {
       // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
       print("collapsedDrawerHeight2")
       
       return 68.0 + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
       
   }
   
   func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
   {
       // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
    print("partialRevealDrawerHeight2")
       return 264.0 + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
   }
   
   func supportedDrawerPositions() -> [PulleyPosition] {
        print("supportedDrawerPositions2")
       return PulleyPosition.all // You can specify the drawer positions you support. This is the same as: [.open, .partiallyRevealed, .collapsed, .closed]
   }
   
   // This function is called by Pulley anytime the size, drawer position, etc. changes. It's best to customize your VC UI based on the bottomSafeArea here (if needed). Note: You might also find the `pulleySafeAreaInsets` property on Pulley useful to get Pulley's current safe area insets in a backwards compatible (with iOS < 11) way. If you need this information for use in your layout, you can also access it directly by using `drawerDistanceFromBottom` at any time.
   func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat)
   {
       // We want to know about the safe area to customize our UI. Our UI customization logic is in the didSet for this variable.
       
    
        print("drawerPositionDidChange2")
        
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
       if drawer.drawerPosition != .open
       {
           searchBar.resignFirstResponder()
       }
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

/*
 * Delegate was set in storyboard: left drag search field to header of view controller (icon, then "delegate")
 */

extension DrawerContentViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("search bar delegate did begin editing")
        pulleyViewController?.setDrawerPosition(position: .open, animated: true)
        print("search bar empty is \(isSearchBarEmpty)")
        /*
        if( isSearchBarEmpty ) {
            tableView.isHidden = true
        }
        */
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let txt = searchBar.text {
            print("search bar delegate button clicked txt is \(txt)")
        }
        searchBar.resignFirstResponder()
        pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        print("search bar changed search text is \(String(describing: searchBar.text))")
        if let searchTerm = searchBar.text {
            filterContentForSearchText(searchTerm)
        }
        /*
        if( isSearchBarEmpty ) {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
         */
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filteredContents = contents.filter { (content: String) -> Bool in
          return content.lowercased().contains(searchText.lowercased())
      }
      tableView.reloadData()
    }
}


extension DrawerContentViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
    print("update search results")
   
  }
}



 

