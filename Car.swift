//
//  Car.swift
//  CarLog2
//
//  Created by Berke Sağdıç on 12.07.2026.
//

import Foundation
import SwiftData

@Model
class Car {
    init(
        brand: String,
        model: String,
        year: String,
        plate: String,
        mileage: String
    ) {
        self.brand = brand
        self.model = model
        self.year = year
        self.plate = plate
        self.mileage = mileage
    }
    
    var brand: String
    var model: String
    var year: String
    var plate: String
    var mileage: String
    
    @Relationship(deleteRule: .cascade)
    var maintenances: [Maintenance] = []
    
    @Relationship(deleteRule: .cascade, inverse: \FuelLog.car)
    var fuelLogs: [FuelLog] = []
}
