//
//  ViewController.swift
//  Miji
//
//  Created by Panja on 11/26/15.
//  Copyright © 2015 Panja. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    //Connections
    @IBOutlet weak var AdminPassword: NSSecureTextField!
    @IBOutlet weak var AdminPanel: NSButton!
    @IBOutlet weak var JobLabel: NSTextField!
    @IBOutlet weak var SubmitN: NSButton!
    @IBOutlet weak var NumberBox: NSTextField!
    @IBOutlet weak var JobButton: NSButton!
    @IBOutlet weak var LockButton: NSButton!
    
    //Variables
    var psub = false; //If # of Players Have Been Submited
    var players = 4;
    var i = 0;
    var positions:Array = [""];
    var showing = false;
    var mTest = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        AdminPanel.hidden = true;
        LockButton.hidden = true;
        APanel();
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    //Passing Positions to Admin Panel
    let shareData = ShareData.sharedInstance
    
    //^^^
    
    // -*- Admin Panel -*- //
    @IBAction func AdminLogin(sender: AnyObject) {
        if(AdminPassword.stringValue == "admin"){
            if(psub == true){
                AdminPanel.hidden = false;
                AdminPassword.stringValue = "";
                LockButton.hidden = false;
            }else{
                let PasInsert:NSAlert = NSAlert();
                PasInsert.messageText = "Please Input The # of Players First!";
                PasInsert.informativeText = "";
                PasInsert.runModal();
            }
        }else{
            let IncorAdmin:NSAlert = NSAlert();
            IncorAdmin.messageText = "Incorrect Password";
            IncorAdmin.informativeText = "";
            IncorAdmin.runModal();
        }
    }
    func APanel() {
        
    }
    @IBAction func LockPanel(sender: AnyObject) {
        AdminPassword.stringValue = "";
        AdminPanel.hidden = true;
        LockButton.hidden = true;
        print("Panel Locked");
    }
    // -*- ^ Admin Panel ^ -*- //
    @IBAction func Submit(sender: AnyObject) {
        players = Int(NumberBox.stringValue)!;
        psub = true;
        AdminPanel.hidden = true;
        LockButton.hidden = true;
        i = 0;
        showing = false;
        JobButton.stringValue = "Click For Your Job";
        JobLabel.stringValue = "Click ^";
        SA(players);
    }
    
    //Print Job On Screen
    @IBAction func ToggleJob(sender: AnyObject) {
        JobButton.stringValue = "Click To Clear";
        positions = self.shareData.positions;
        if(showing == false){
            if !(i >= players){
                if !(positions[i] == "Murderer"){
                    JobLabel.stringValue = "\(positions[i])"
                }else{
                    if(players >= 7){
                        if(mTest == false){
                            JobLabel.stringValue = "Murderer - Kill 2!"
                        }else{
                            JobLabel.stringValue = "Murderer - Kill 1"
                        }
                    }else if(players >= 5){
                        let randomNumber = arc4random_uniform(2)
                        if(randomNumber == 1){
                            JobLabel.stringValue = "Murderer - Kill 1"
                        }else if(randomNumber == 2){
                            if(mTest == false){
                                JobLabel.stringValue = "Murderer - Kill 2"
                                mTest = true;
                            }else{
                                JobLabel.stringValue = "Murderer - Kill 1"
                            }
                        }
                    }
                }
                i++;
                showing = true;
            }else{
                JobLabel.stringValue = "Done"
            }
        }else if(showing == true){
            JobLabel.stringValue = "";
            showing = false;
        }
    }
    
    
    //Setup Array With Positions
    func SA(players: Int){
        positions = ["Murderer", "Judge", "Innocent", "Innocent"]; //Pre-set Positions
        if(players == 5){
            positions += (["Co-Judge"]);
        }else if(players == 6){
            positions += (["Innocent", "Co-Judge"]);
        }else if(players == 7){
            positions += (["Murderer-2!", "Innocent", "Co-Judge"]);
        }else if(players == 8){
            positions += (["Murderer-2!", "Innocent", "Co-Judge", "Angel"]);
        }else if(players == 9){
            positions += (["Murderer-2", "Innocent", "Co-Judge", "Angel", "Innocent"]);
        }
        //Shuffle Job Order
        positions.shuffle();
        positions = positions.shuffle();
        print("\(positions)");
        self.shareData.positions = positions;
    }
    
}

//Randomizers

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var positions = Array(self)
        positions.shuffleInPlace()
        return positions
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

