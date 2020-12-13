//
//  Result.swift
//  NyTimesNewsApp
//
//  Created by Admin on 12/14/20.
//

import Foundation

//MARK:- Service enums
enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
