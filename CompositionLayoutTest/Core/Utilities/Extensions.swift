//
//  Extensions.swift
//  CompositionLayoutTest
//
//  Created by Abdul Qadar on 28/04/2025.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Task where Success == Never, Failure == Never {
    static func sleep(for duration: Duration) async throws {
        try await Task.sleep(nanoseconds: duration.nanoseconds)
    }
}

extension Duration {
    var nanoseconds: UInt64 {
        switch self {
        case .seconds(let value):
            return UInt64(Double(value) * 1_000_000_000)
        case .milliseconds(let value):
            return UInt64(Double(value) * 1_000_000)
        case .microseconds(let value):
            return UInt64(Double(value) * 1_000)
        case .nanoseconds(let value):
            return UInt64(value)
        }
    }
}

enum Duration {
    case seconds(Double)
    case milliseconds(Double)
    case microseconds(Double)
    case nanoseconds(Double)
}
