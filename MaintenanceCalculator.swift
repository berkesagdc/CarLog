import Foundation

struct MaintenanceCalculator {

    static func nextMaintenanceMileage(for maintenance: Maintenance) -> Int? {

        guard
            let currentMileage = Int(maintenance.mileage),
            let repeatMileage = Int(maintenance.repeatMileage)
        else {
            return nil
        }

        return currentMileage + repeatMileage
    }

    static func remainingMileage(
        currentMileage: String,
        maintenance: Maintenance
    ) -> Int? {

        guard
            let vehicleMileage = Int(currentMileage),
            let nextMileage = nextMaintenanceMileage(for: maintenance)
        else {
            return nil
        }

        return nextMileage - vehicleMileage
    }
}
