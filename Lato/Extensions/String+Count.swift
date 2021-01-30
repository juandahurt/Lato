//
//  String+Count.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

extension String {
    func count(of character: Character) -> Int {
        return reduce(0) {
            $1 == character ? $0 + 1 : $0
        }
    }
}
