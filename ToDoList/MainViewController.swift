//
//  MainViewController.swift
//  ToDoList
//
//  Created by dshs_student on 2016. 11. 5..
//  Copyright © 2016년 DGSW_TEACHER. All rights reserved.
//

import UIKit

var listTitles = ["나르샤캠프 iOS반 숙제", "나르샤캠프 iOS반 어플 마무리짓기"]
var listDeadLines = ["2016.10.22 12:00까지", "2016.12.31 09:00까지"]
var listImages = []

class MainViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
    var searchController:UISearchController!
    
    let noDataLabel = UILabel()
    
    @IBOutlet weak var mainTableView: UITableView!
    
    @IBAction func Search(sender: AnyObject) {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
        
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTitles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1",forIndexPath: indexPath) as! listTableViewCell
        cell.listTitle.text = listTitles[indexPath.row]
        cell.listDeadLine.text = listDeadLines[indexPath.row]
        cell.listImageView = nil
        return cell
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            listTitles.removeAtIndex(indexPath.row)
            listDeadLines.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
