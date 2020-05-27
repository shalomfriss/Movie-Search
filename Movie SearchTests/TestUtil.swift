//
//  TestUtil.swift
//  Movie SearchTests
//
//  Created by user on 5/7/20.
//  Copyright © 2020 Shalom Friss. All rights reserved.
//

import Foundation

class TestUtil {
    static func readJSONFromFile(fileName: String) -> String?
    {
        if let filepath = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
