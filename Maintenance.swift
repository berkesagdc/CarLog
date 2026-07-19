import Foundation
import SwiftData

@Model
class Maintenance {

    var title: String
    var date: Date
    var mileage: String
    var repeatMileage: String
    var note: String

    var car: Car?

    init(
        title: String,
        date: Date,
        mileage: String,
        repeatMileage: String,
        note: String
    ) {
        self.title = title
        self.date = date
        self.mileage = mileage
        self.repeatMileage = repeatMileage
        self.note = note
    }
}
