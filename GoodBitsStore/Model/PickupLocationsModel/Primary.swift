

import Foundation
struct Primary : Codable {
	let landscape : String?
	let full_landscape : String?
	let portrait : String?
	let full_portrait : String?

	enum CodingKeys: String, CodingKey {

		case landscape = "landscape"
		case full_landscape = "full_landscape"
		case portrait = "portrait"
		case full_portrait = "full_portrait"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		landscape = try values.decodeIfPresent(String.self, forKey: .landscape)
		full_landscape = try values.decodeIfPresent(String.self, forKey: .full_landscape)
		portrait = try values.decodeIfPresent(String.self, forKey: .portrait)
		full_portrait = try values.decodeIfPresent(String.self, forKey: .full_portrait)
	}

}
