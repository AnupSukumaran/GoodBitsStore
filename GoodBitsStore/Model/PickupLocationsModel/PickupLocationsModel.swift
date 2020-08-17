

import Foundation
struct PickupLocationsModel : Codable {
	let number_of_new_locations : Int?
	let pickup : [Pickup]?

	enum CodingKeys: String, CodingKey {

		case number_of_new_locations = "number_of_new_locations"
		case pickup = "pickup"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		number_of_new_locations = try values.decodeIfPresent(Int.self, forKey: .number_of_new_locations)
		pickup = try values.decodeIfPresent([Pickup].self, forKey: .pickup)
	}

}
