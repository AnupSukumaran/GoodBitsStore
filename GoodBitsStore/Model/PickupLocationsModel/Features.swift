

import Foundation
struct Features : Codable {
	let type : String?
	let description : String?

	enum CodingKeys: String, CodingKey {

		case type = "type"
		case description = "description"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		description = try values.decodeIfPresent(String.self, forKey: .description)
	}

}
