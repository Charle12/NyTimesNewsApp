//
//  ErrorResult.swift
//  NyTimesNewsApp
//
//  Created by Admin on 12/14/20.
//

import Foundation

//MARK:- Service enums
enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
