//
//  ViewController.swift
//  UISearchController
//
//  Created by Mohamed on 8/24/19.
//  Copyright © 2019 Mohamed74. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {

    var searchController: UISearchController!
    
    @IBOutlet weak var tableView: UITableView!
    
    var originalData:[String] = []
    var currentData:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = .white
        
        addDataToOurSearchView(productName: "LapTop", count: 15)
        addDataToOurSearchView(productName: "MacBookAir", count: 15)
        addDataToOurSearchView(productName: "MacBookBro", count: 15)
        addDataToOurSearchView(productName: "iPhone", count: 15)
        
        currentData = originalData
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.searchController = searchController
        
        // add our products which we will search in it
        
       
       
        
    }
   
    
    @IBAction func btn_RestoreData(_ sender: UIButton) {
        
        currentData = originalData
        
        tableView.reloadData()
        
    }
    
  
    
 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
      
    }
    
    func addDataToOurSearchView(productName:String , count:Int){
        
        for counter in 1...count {
            
            originalData.append("\(productName) : \(counter)")
        }
    }
    
    func filterDataInSearchView(searchText: String){
        
        if searchText.count > 0 {
            
            currentData = originalData
            
            let DataFiltered = currentData.filter {
                $0.replacingOccurrences(of: " ", with: "").lowercased()
                    .contains(searchText.replacingOccurrences(of: " ", with: "").lowercased())
            }
            
            
            currentData = DataFiltered
            
            
            tableView.reloadData()
        }
        
        
    }

}

extension ViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text{
            
            filterDataInSearchView(searchText: searchText)
        }
        
    }
    
    
    
    
}
extension ViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      
        searchController.isActive = false
        
        if let searchText = searchBar.text{
            
        
            filterDataInSearchView(searchText: searchText)
            
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchText = searchBar.text, !searchText.isEmpty {
            
            // restore data
            
        }
        
    }
}

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for: indexPath)
        
        cell.textLabel?.text = currentData[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let alertController = UIAlertController(title: "SearchController", message: "you choose product\(currentData[indexPath.row])", preferredStyle: .alert)
        
        searchController.isActive = false
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
}

