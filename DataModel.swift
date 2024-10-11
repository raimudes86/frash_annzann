//
//  DataModel.swift
//  testmodal
//
//  Created by 木下来夢 on 2024/09/14.
//

import SwiftUI

class DataModel: ObservableObject{
    @Published var kousuu: Int = 5
    @Published var ketasuu: Int = 1
    @Published var hyoujiKankaku: Double = 1.00
}
