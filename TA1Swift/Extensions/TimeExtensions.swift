//
//  TimeExtensions.swift
//  TA1Swift
//
//  Created by Сергей Иванчихин on 29.10.2023.
//

import Foundation

func getCurrentTime() -> String {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    let formatMinutes = minutes < 10 ? "0\(minutes)" : String(minutes)
    let time = "\(hour):\(formatMinutes)"
    return time
}
