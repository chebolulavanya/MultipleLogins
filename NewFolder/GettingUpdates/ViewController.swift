//
//  ViewController.swift
//  GettingUpdates
//
//  Created by Lavanya Chebolu on 04/11/20.
//  Copyright © 2020 Lavanya Chebolu. All rights reserved.
//

import UIKit
import AVFoundation
import PushKit
import CallKit
import TwilioVoice



class ViewController: UIViewController, Queue {
    let deviceData = Data()
    private var items: [Int] = []
    @IBAction func callAction(_ sender: UIButton) {
        
        TwilioVoiceSDK.register(accessToken: "accessToken", deviceToken: deviceData) { error in
               if let error = error {
                   NSLog("An error occurred while registering: \(error.localizedDescription)")
               } else {
                   NSLog("Successfully registered for VoIP push notifications.")
               }
           }
    }
    var count: Int {
        return items.count
    }
    
    func push(_ element: Int) {
        items.append(element)
    }
    
    func pop() -> Int {
        return items.removeFirst()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

