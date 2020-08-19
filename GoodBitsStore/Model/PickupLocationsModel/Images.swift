

import Foundation
struct Images : Codable {
	let store : Store?
	let floormap : Floormap?

	enum CodingKeys: String, CodingKey {

		case store = "store"
		case floormap = "floormap"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		store = try values.decodeIfPresent(Store.self, forKey: .store)
		floormap = try values.decodeIfPresent(Floormap.self, forKey: .floormap)
	}

}
