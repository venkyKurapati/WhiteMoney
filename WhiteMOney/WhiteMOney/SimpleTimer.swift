//
//  SimpleTimer.swift
//  WhiteMOney
//
//  Created by Venkatesh on 09/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class SimpleTimer {/*<--was named Timer, but since swift 3, NSTimer is now Timer*/
    typealias Tick = ()->Void
    var timer:Timer?
    var interval:TimeInterval /*in seconds*/
    var repeats:Bool
    var tick:Tick
    
    init( interval:TimeInterval, repeats:Bool = false, onTick:@escaping Tick){
        self.interval = interval
        self.repeats = repeats
        self.tick = onTick
    }
    func start(){
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(update), userInfo: nil, repeats: true)//swift 3 upgrade
    }
    func stop(){
        if(timer != nil){timer!.invalidate()}
    }
    /**
     * This method must be in the public or scope
     */
    @objc func update() {
        tick()
    }
}
