import Foundation
import SwiftData

@Model
class FuelLog {

    var date: Date
    var mileage: String
    var liters: String
    var totalPrice: String

    var car: Car?

    init(
        date: Date = Date(),
        mileage: String,
        liters: String,
        totalPrice: String
    ) {
        self.date = date
        self.mileage = mileage
        self.liters = liters
        self.totalPrice = totalPrice
    }

    var pricePerLiter: Double? {

        guard
            let liters = Double(liters),
            let total = Double(totalPrice),
            liters > 0
        else {
            return nil
        }

        return total / liters
    }
}
