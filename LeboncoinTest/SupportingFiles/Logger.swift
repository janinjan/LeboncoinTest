//
//  Logger.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation
import os

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier!
    
    static let networking = OSLog(subsystem: subsystem, category: "networking")
}
