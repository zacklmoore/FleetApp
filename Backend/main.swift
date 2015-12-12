//
//  main.swift
//  Backend
//
//  Created by Emily Greinwald on 12/11/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import Foundation
import Riffle

let app = RiffleDomain(domain: "xs.demo.geobadger.fleet")

class Container: RiffleDomain {
    override func onJoin() {
        print("Domain joined")
        
        register("play", play)
    }
    
    func play(player: String) -> AnyObject {
        print("\(player) says hello!")
        return "Hi, \(player)!"
    }


   



func playerLeft(domain: String) {
    print("Domain left: \(domain)")
}
    
    //instructions less clear for this function. The documentation references onJoin in main.swift but it hadn't previously told me to implement this function here.
    func onJoin(){
        app.subscribe("sessionLeft", playerLeft)
    }

}

let container = Container(name: "gamelogic", superdomain: app)
container.join()
NSRunLoop.currentRunLoop().run()