import Foundation

struct FuelCalculator {

    static func averageConsumption(for logs: [FuelLog]) -> Double? {

        let sortedLogs = logs.sorted { $0.date < $1.date }

        guard sortedLogs.count >= 2 else {
            return nil
        }

        var consumptions: [Double] = []

        for index in 1..<sortedLogs.count {

            let previous = sortedLogs[index - 1]
            let current = sortedLogs[index]

            guard
                let previousMileage = Double(previous.mileage),
                let currentMileage = Double(current.mileage),
                let liters = Double(current.liters)
            else {
                continue
            }

            let distance = currentMileage - previousMileage

            guard distance > 0 else {
                continue
            }

            let consumption = (liters * 100) / distance
            consumptions.append(consumption)
        }

        guard !consumptions.isEmpty else {
            return nil
        }

        let total = consumptions.reduce(0, +)
        return total / Double(consumptions.count)
    }
}
