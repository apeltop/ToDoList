//
//  listTableViewCell.swift
//  Layout
//
//  Created by user on 2016. 10. 21..
//  Copyright © 2016년 DGSW. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listDeadLine: UILabel!
    @IBOutlet weak var checkImg: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
