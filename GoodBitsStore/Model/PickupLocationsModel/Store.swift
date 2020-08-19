

import Foundation
struct Store : Codable {
	let primary : Primary?
	let secondary : String?
	let full_secondary : String?

	enum CodingKeys: String, CodingKey {

		case primary = "primary"
		case secondary = "secondary"
		case full_secondary = "full_secondary"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		primary = try values.decodeIfPresent(Primary.self, forKey: .primary)
		secondary = try values.decodeIfPresent(String.self, forKey: .secondary)
		full_secondary = try values.decodeIfPresent(String.self, forKey: .full_secondary)
	}

}
