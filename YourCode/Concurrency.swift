//
//  Concurrency.swift


import Foundation

func loadGreetingMessage(timeout: DispatchTimeInterval, completion: @escaping (String) -> Void) {
    
    var hello = ""
    var world = ""
    let dispatchQueue = DispatchQueue.global()
    let dispatchGroup = DispatchGroup()
    let timeoutMessage = "Unable to load message - Time out exceeded"
    
    DispatchQueue.global(qos: .userInitiated).async {
        dispatchGroup.enter()
               dispatchQueue.async(group: dispatchGroup) {
                   fetchMessageOne { (messageHello) in
                       hello = messageHello
                       dispatchGroup.leave()
                   }
               }
               dispatchGroup.enter()
               dispatchQueue.async(group: dispatchGroup) {
                   fetchMessageTwo { (messageWorld) in
                       world = messageWorld
                       dispatchGroup.leave()
                   }
               }
               
               let timeoutResult = dispatchGroup.wait(timeout: .now() + timeout)
               let loadedMessage = timeoutResult == .success ? "\(hello) \(world)!" : timeoutMessage
        DispatchQueue.main.async {
            completion(loadedMessage)
        }
    }
}
