//
//  AnalyticsService.swift
//  Tracker
//
//  Created by Gleb on 30.07.2024.
//

import Foundation
import YandexMobileMetrica

enum AnaliticEvent: String {
    case open = "Open"
    case close = "Close"
    case click = "Click"
}

final class AnalyticsService {
    static func activate() {
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: "7ba425cf-8711-432f-b5c8-572c48043f6b") else { return }
        
        YMMYandexMetrica.activate(with: configuration)
    }
    
    func report(event: AnaliticEvent, params : [AnyHashable : Any]) {
        YMMYandexMetrica.reportEvent(event.rawValue, parameters: params, onFailure: { error in
            print("REPORT ERROR: %@", error.localizedDescription)
        })
    }
}
