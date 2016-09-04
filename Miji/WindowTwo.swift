//
//  WindowTwo.swift
//  Miji
//
//  Created by Panja on 11/27/15.
//  Copyright © 2015 Panja. All rights reserved.
//

import Cocoa

class WindowTwo: NSViewController {
    @IBOutlet weak var JobN: NSTextField!
    @IBOutlet weak var JobR: NSTextField!
    
    @IBOutlet weak var AllR: NSTextField!
    
    var positions = [""]
    
    let shareData = ShareData.sharedInstance
    
    override func viewDidLoad() {
        positions = self.shareData.positions;
        print("\(positions) - WindowTwo")
        AllR.stringValue = "\(positions)"
    }
    
    
    @IBAction func OnChange(sender: AnyObject) {
        var i = (Int(JobN.stringValue)! - 1);
        positions[i] = JobR.stringValue;
        self.shareData.positions = positions;
        AllR.stringValue = "\(positions)"
    }
    
}
