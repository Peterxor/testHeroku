//
//  HelloController.swift
//  App
//
//  Created by Peter on 2018/5/16.
//

import Foundation
import Vapor

final class HelloController{
    func greet(_ Req: Request) throws -> String{
        return "Hello"
    }
}
