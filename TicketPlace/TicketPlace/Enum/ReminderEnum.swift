//
//  ReminderEnum.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 07/11/25.
//

import Foundation

enum ReminderEnum: String, CaseIterable, Decodable {
    case fiveMinutes = "5 min Antes"
    case fifteenMinutes = "15 min Antes"
    case thirtyMinutes = "30 min Antes"
    case oneHour = "1 hora Antes"
    case oneDay = "1 dia Antes"
    case threeDays = "3 dias Antes"
}
