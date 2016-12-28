//
//  AddTableViewController.swift
//  ToDoList
//
//  Created by dshs_student on 2016. 12. 28..
//  Copyright © 2016년 DGSW_TEACHER. All rights reserved.
//

import UIKit

let pickerAnimationDuration = 0.40 // duration for the animation to slide the date picker into view
let datePickerTag           = 99   // view tag identifiying the date picker view

let titleKey = "title" // key for obtaining the data source item's title
let dateKey  = "date"  // key for obtaining the data source item's date value

// keep track of which rows have date cells
let dateStartRow = 1
let dateEndRow   = 2

let dateCellID   = "dateCell"   // the cells with the start or end date
let datePickerID = "datePicker" // the cell containing the date picker
let otherCell    = "otherCell"  // the remaining cells at the end

class AddTableViewController: UITableViewController {

    var dataArray = [[String: AnyObject]]()
    var dateFormatter: NSDateFormatter = {
        var _dateFormatter = NSDateFormatter()
        
        _dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle // show short-style date format
        _dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        
        return _dateFormatter
    }()
    
    // keep track which indexPath points to the cell with UIDatePicker
    var datePickerIndexPath: NSIndexPath?
    
    lazy var pickerCellRowHeight: CGFloat = {
        [unowned self] in
        
        // obtain the picker view cell's height, works because the cell was pre-defined in our storyboard
        let pickerViewCellToCheck = self.tableView.dequeueReusableCellWithIdentifier(datePickerID)
        
        return CGRectGetHeight(pickerViewCellToCheck!.frame)
        }()
    
    /// Primary view has been loaded for this view controller
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup our data source
        let itemOne = [titleKey: "Tap a cell to change its date:"]
        let itemTwo = [titleKey: "Start Date", dateKey: NSDate()]
        let itemThree = [titleKey: "End Date", dateKey: NSDate()]
        let itemFour = [titleKey: "(other item1)"]
        let itemFive = [titleKey: "(other item2)"]
        self.dataArray = [itemOne, itemTwo, itemThree, itemFour, itemFive]
        
        // if the local changes while in the background, we need to be notified so we can update the date
        // format in the table view cells
        //
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "localeChanged:", name: NSCurrentLocaleDidChangeNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NSCurrentLocaleDidChangeNotification, object: nil)
    }
    
    // MARK: - Locale
    
    /// Responds to region format or locale changes.
    ///
    func localeChanged(notif: NSNotification) {
        // the user changed the locale (region format) in Settings, so we are notified here to
        // update the date format in the table view cells
        //
        self.tableView.reloadData()
    }
    
    // MARK: - Utilities
    
    /// Determines if the given indexPath has a cell below it with a UIDatePicker.
    ///
    /// - parameters:
    ///   - indexPath: The indexPath to check if its cell has a UIDatePicker below it.
    ///
    func hasPickerForIndexPath(indexPath: NSIndexPath) -> Bool {
        var hasDatePicker = false
        
        var targetedRow = indexPath.row
        targetedRow++
        
        let checkDatePickerCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: targetedRow, inSection: 0))
        let checkDatePicker = checkDatePickerCell?.viewWithTag(datePickerTag)
        
        hasDatePicker = checkDatePicker != nil
        return hasDatePicker
    }
    
    /// Updates the UIDatePicker's value to match with the date of the cell above it.
    ///
    func updateDatePicker() {
        if (self.datePickerIndexPath != nil) {
            let associatedDatePickerCell = self.tableView.cellForRowAtIndexPath(self.datePickerIndexPath!)
            let targetedDatePicker = associatedDatePickerCell?.viewWithTag(datePickerTag) as? UIDatePicker
            
            if (targetedDatePicker != nil) {
                // we found a UIDatePicker in this cell, so update it's date value
                //
                let itemData = self.dataArray[self.datePickerIndexPath!.row - 1]
                targetedDatePicker!.setDate(itemData[dateKey] as! NSDate, animated: false)
            }
        }
    }
    
    /// Determines if the UITableViewController has a UIDatePicker in any of its cells.
    ///
    func hasInlineDatePicker() -> Bool {
        return self.datePickerIndexPath != nil
    }
    
    /// Determines if the given indexPath points to a cell that contains the UIDatePicker.
    ///
    /// - parameters:
    ///   - indexPath: The indexPath to check if it represents a cell with the UIDatePicker.
    ///
    func indexPathHasPicker(indexPath: NSIndexPath) -> Bool {
        return self.hasInlineDatePicker() && self.datePickerIndexPath!.row == indexPath.row
    }
    
    /// Determines if the given indexPath points to a cell that contains the start/end dates.
    ///
    /// - parameters:
    ///   - indexPath: The indexPath to check if it represents start/end date cell.
    ///
    func indexPathHasDate(indexPath: NSIndexPath)-> Bool {
        var hasDate = false
        
        if ((indexPath.row == dateStartRow) ||
            (indexPath.row == dateEndRow || (self.hasInlineDatePicker() && (indexPath.row == dateEndRow + 1))))
        {
            hasDate = true
        }
        
        return hasDate
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.indexPathHasPicker(indexPath) ? self.pickerCellRowHeight : self.tableView.rowHeight
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.hasInlineDatePicker()) {
            // we have a date picker, so allow for it in the number of rows in this section
            var numRows = self.dataArray.count
            return ++numRows
        }
        
        return self.dataArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell?
        var cellID = otherCell
        
        if (self.indexPathHasPicker(indexPath)) {
            // the indexPath is the one containing the inline date picker
            cellID = datePickerID;     // the current/opened date picker cell
        } else if (self.indexPathHasDate(indexPath)) {
            // the indexPath is one that contains the date information
            cellID = dateCellID;       // the start/end date cells
        }
        
        cell = tableView.dequeueReusableCellWithIdentifier(cellID)
        
        if (indexPath.row == 0) {
            // we decide here that first cell in the table is not selectable (it's just an indicator)
            cell!.selectionStyle = UITableViewCellSelectionStyle.None;
        }
        
        // if we have a date picker open whose cell is above the cell we want to update,
        // then we have one more cell than the model allows
        //
        var modelRow = indexPath.row
        if (self.datePickerIndexPath != nil && self.datePickerIndexPath!.row <= indexPath.row) {
            modelRow--
        }
        
        let itemData = self.dataArray[modelRow]
        
        // proceed to configure our cell
        if (cellID == dateCellID) {
            // we have either start or end date cells, populate their date field
            //
            cell!.textLabel!.text = itemData[titleKey] as? String
            cell!.detailTextLabel!.text = self.dateFormatter.stringFromDate(itemData[dateKey] as! NSDate)
        } else if (cellID == otherCell) {
            // this cell is a non-date cell, just assign it's text label
            //
            cell!.textLabel!.text = itemData[titleKey] as? String
        }
        
        return cell!
    }
    
    /// Adds or removes a UIDatePicker cell below the given indexPath.
    ///
    /// - parameters:
    ///   - indexPath: The indexPath to reveal the UIDatePicker.
    ///
    func toggleDatePickerForSelectedIndexPath(indexPath: NSIndexPath) {
        self.tableView.beginUpdates()
        
        let indexPaths = [NSIndexPath(forRow: indexPath.row + 1, inSection: 0)]
        
        // check if 'indexPath' has an attached date picker below it
        if (self.hasPickerForIndexPath(indexPath)) {
            // found a picker below it, so remove it
            self.tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
        } else {
            // didn't find a picker below it, so we should insert it
            self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
        }
        
        self.tableView.endUpdates()
    }
    
    /// Reveals the date picker inline for the given indexPath, called by "didSelectRowAtIndexPath".
    ///
    /// - parameters:
    ///   - indexPath: The indexPath to reveal the UIDatePicker.
    ///
    func displayInlineDatePickerForRowAtIndexPath(indexPath: NSIndexPath) {
        // display the date picker inline with the table content
        self.tableView.beginUpdates()
        
        var before = false   // indicates if the date picker is below "indexPath", help us determine which row to reveal
        if (self.hasInlineDatePicker()) {
            before = self.datePickerIndexPath!.row < indexPath.row
        }
        
        let sameCellClicked = self.datePickerIndexPath?.row == indexPath.row + 1
        
        // remove any date picker cell if it exists
        if (self.hasInlineDatePicker()) {
            self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: self.datePickerIndexPath!.row, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
            self.datePickerIndexPath = nil
        }
        
        if (!sameCellClicked) {
            // hide the old date picker and display the new one
            let rowToReveal = before ? indexPath.row - 1 : indexPath.row
            let indexPathToReveal = NSIndexPath(forRow:rowToReveal, inSection:0)
            
            self.toggleDatePickerForSelectedIndexPath(indexPathToReveal)
            self.datePickerIndexPath = NSIndexPath(forRow: indexPathToReveal.row + 1, inSection: 0)
        }
        
        // always deselect the row containing the start or end date
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.tableView.endUpdates()
        
        // inform our date picker of the current date to match the current cell
        self.updateDatePicker()
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if (cell!.reuseIdentifier == dateCellID) {
            self.displayInlineDatePickerForRowAtIndexPath(indexPath)
        } else {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    // MARK: - Actions
    
    /// User chose to change the date by changing the values inside the UIDatePicker.
    ///
    /// - parameters:
    ///   - sender: The sender for this action: UIDatePicker.
    ///
    @IBAction func dateAction(sender: UIDatePicker) {
        if (self.datePickerIndexPath != nil) {
            let targetedCellIndexPath = NSIndexPath(forRow: self.datePickerIndexPath!.row - 1, inSection: 0)
            let cell = self.tableView.cellForRowAtIndexPath(targetedCellIndexPath)
            let targetedDatePicker = sender
            
            // update our data model
            var itemData = self.dataArray[targetedCellIndexPath.row]
            itemData[dateKey] = targetedDatePicker.date
            
            // update the cell's date string
            cell!.detailTextLabel!.text = self.dateFormatter.stringFromDate(targetedDatePicker.date)
        }
    }

}
