
import Foundation
struct Floormap : Codable {
	let main : String?
	let full_main : String?
	let zoomed : String?
	let full_zoomed : String?

	enum CodingKeys: String, CodingKey {

		case main = "main"
		case full_main = "full_main"
		case zoomed = "zoomed"
		case full_zoomed = "full_zoomed"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		main = try values.decodeIfPresent(String.self, forKey: .main)
		full_main = try values.decodeIfPresent(String.self, forKey: .full_main)
		zoomed = try values.decodeIfPresent(String.self, forKey: .zoomed)
		full_zoomed = try values.decodeIfPresent(String.self, forKey: .full_zoomed)
	}

}
