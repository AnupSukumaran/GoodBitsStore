/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Pickup : Codable {
	let feature : String?
	let id_pickup_location : Int?
	let id_country : Int?
	let id_state : Int?
	let id_carrier : Int?
	let company : String?
	let nps_link : String?
	let alias : String?
	let address1 : String?
	let address2 : String?
	let district : String?
	let city : String?
	let postcode : String?
	let latitude : Double?
	let longitude : Double?
	let phone : String?
	let nearest_bts : String?
	let notable_area : String?
	let hours1 : String?
	let hours2 : String?
	let hours3 : String?
	let description : String?
	let is_featured : Bool?
	let subtype : String?
	let store_image_path : String?
	let floormap_image_path : String?
	let active : Bool?
	let floor_number : String?
	let status : String?
	let id_zone : Int?
	let features : [Features]?
	let is_new_location : Bool?
	let type : String?
	let hours : [String]?
	let images : Images?
	let is_default_location : Bool?

	enum CodingKeys: String, CodingKey {

		case feature = "feature"
		case id_pickup_location = "id_pickup_location"
		case id_country = "id_country"
		case id_state = "id_state"
		case id_carrier = "id_carrier"
		case company = "company"
		case nps_link = "nps_link"
		case alias = "alias"
		case address1 = "address1"
		case address2 = "address2"
		case district = "district"
		case city = "city"
		case postcode = "postcode"
		case latitude = "latitude"
		case longitude = "longitude"
		case phone = "phone"
		case nearest_bts = "nearest_bts"
		case notable_area = "notable_area"
		case hours1 = "hours1"
		case hours2 = "hours2"
		case hours3 = "hours3"
		case description = "description"
		case is_featured = "is_featured"
		case subtype = "subtype"
		case store_image_path = "store_image_path"
		case floormap_image_path = "floormap_image_path"
		case active = "active"
		case floor_number = "floor_number"
		case status = "status"
		case id_zone = "id_zone"
		case features = "features"
		case is_new_location = "is_new_location"
		case type = "type"
		case hours = "hours"
		case images = "images"
		case is_default_location = "is_default_location"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		feature = try values.decodeIfPresent(String.self, forKey: .feature)
		id_pickup_location = try values.decodeIfPresent(Int.self, forKey: .id_pickup_location)
		id_country = try values.decodeIfPresent(Int.self, forKey: .id_country)
		id_state = try values.decodeIfPresent(Int.self, forKey: .id_state)
		id_carrier = try values.decodeIfPresent(Int.self, forKey: .id_carrier)
		company = try values.decodeIfPresent(String.self, forKey: .company)
		nps_link = try values.decodeIfPresent(String.self, forKey: .nps_link)
		alias = try values.decodeIfPresent(String.self, forKey: .alias)
		address1 = try values.decodeIfPresent(String.self, forKey: .address1)
		address2 = try values.decodeIfPresent(String.self, forKey: .address2)
		district = try values.decodeIfPresent(String.self, forKey: .district)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		postcode = try values.decodeIfPresent(String.self, forKey: .postcode)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		nearest_bts = try values.decodeIfPresent(String.self, forKey: .nearest_bts)
		notable_area = try values.decodeIfPresent(String.self, forKey: .notable_area)
		hours1 = try values.decodeIfPresent(String.self, forKey: .hours1)
		hours2 = try values.decodeIfPresent(String.self, forKey: .hours2)
		hours3 = try values.decodeIfPresent(String.self, forKey: .hours3)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		is_featured = try values.decodeIfPresent(Bool.self, forKey: .is_featured)
		subtype = try values.decodeIfPresent(String.self, forKey: .subtype)
		store_image_path = try values.decodeIfPresent(String.self, forKey: .store_image_path)
		floormap_image_path = try values.decodeIfPresent(String.self, forKey: .floormap_image_path)
		active = try values.decodeIfPresent(Bool.self, forKey: .active)
		floor_number = try values.decodeIfPresent(String.self, forKey: .floor_number)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		id_zone = try values.decodeIfPresent(Int.self, forKey: .id_zone)
		features = try values.decodeIfPresent([Features].self, forKey: .features)
		is_new_location = try values.decodeIfPresent(Bool.self, forKey: .is_new_location)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		hours = try values.decodeIfPresent([String].self, forKey: .hours)
		images = try values.decodeIfPresent(Images.self, forKey: .images)
		is_default_location = try values.decodeIfPresent(Bool.self, forKey: .is_default_location)
	}

}