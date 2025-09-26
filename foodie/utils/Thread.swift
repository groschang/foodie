//
//  Thread.swift
//  foodie
//
//  Created by Konrad Groschang on 20/02/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

extension Thread {
    
    class func printCurrent() {
        Logger.log("\(Thread.current) \(Thread.current.queueName)", onLevel: .info)
    }
}


extension Thread {
    
    var threadName: String {
        if isMainThread {
            return "main"
        } else if let threadName = Thread.current.name, !threadName.isEmpty {
            return threadName
        } else {
            return description
        }
    }
    
    var queueName: String {
        if let queueName = String(validatingCString: __dispatch_queue_get_label(nil)) {
            return queueName
        } else if let operationQueueName = OperationQueue.current?.name, !operationQueueName.isEmpty {
            return operationQueueName
        } else if let dispatchQueueName = OperationQueue.current?.underlyingQueue?.label, !dispatchQueueName.isEmpty {
            return dispatchQueueName
        } else {
            return "n/a"
        }
    }
}
