// This file was generated from JSON Schema using quicktype, do not modify it directly.https://app.quicktype.io/
// To parse the JSON, add this file to your project and do:
//
//   let whpHome = try? JSONDecoder().decode(WhpHome.self, from: jsonData)

import Foundation

// MARK: - WhpHome
struct WhpHome: Codable {
    let indexBannerTop: [IndexBanner]
    let categoryMap: CategoryMap
    let keyWords: [JSONAny]
    let newsCount: Int
    let webTitleType: String
    let indexBrand: [IndexBrand]
    let indexBannerMedium: [IndexBanner]
    let showRegular: String
    let startImg: String
    let serverID: Int
    let indexActive: [IndexActive]
    let appFileUploadURL: String
    let success: Int

    enum CodingKeys: String, CodingKey {
        case indexBannerTop = "index_banner_top"
        case categoryMap = "category_map"
        case keyWords = "key_words"
        case newsCount = "news_count"
        case webTitleType = "web_title_type"
        case indexBrand = "index_brand"
        case indexBannerMedium = "index_banner_medium"
        case showRegular
        case startImg = "start_img"
        case serverID = "server_id"
        case indexActive = "index_active"
        case appFileUploadURL = "app_file_upload_url"
        case success
    }
}

// MARK: - CategoryMap
struct CategoryMap: Codable {
    let channelName: String
    let partAPLURL: String
    let indexCategory: [IndexCategory]
    let grade: Int

    enum CodingKeys: String, CodingKey {
        case channelName = "channel_name"
        case partAPLURL = "part_apl_url"
        case indexCategory = "index_category"
        case grade
    }
}

// MARK: - IndexCategory
struct IndexCategory: Codable {
    let pCatID, pCatName: String
    let pCatTopIcon: String

    enum CodingKeys: String, CodingKey {
        case pCatID = "p_cat_id"
        case pCatName = "p_cat_name"
        case pCatTopIcon = "p_cat_top_icon"
    }
}

// MARK: - IndexActive
struct IndexActive: Codable {
    let activeDesc: String
    let activeID, activeType: Int
    let endTime, timeTilte: String
    let timeDistance: Int
    let activeURL: String
    let products: [Product]
    let startTime: String
    let showType: Int
    let activeImg: String
    let seckillID: Int
    let activeName: String

    enum CodingKeys: String, CodingKey {
        case activeDesc = "active_desc"
        case activeID = "active_id"
        case activeType = "active_type"
        case endTime = "end_time"
        case timeTilte = "time_tilte"
        case timeDistance = "time_distance"
        case activeURL = "active_url"
        case products
        case startTime = "start_time"
        case showType = "show_type"
        case activeImg = "active_img"
        case seckillID = "seckill_id"
        case activeName = "active_name"
    }
}

// MARK: - Product
struct Product: Codable {
    let productID: Int
    let productSn, productModel, productName: String
    let productImage: String
    let price, shortPeriod, activePrice, seckillQty: Int
    let seckilledQty, residueQty, policyID: Int

    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
        case productSn = "product_sn"
        case productModel = "product_model"
        case productName = "product_name"
        case productImage = "product_image"
        case price
        case shortPeriod = "short_period"
        case activePrice = "active_price"
        case seckillQty = "seckill_qty"
        case seckilledQty = "seckilled_qty"
        case residueQty = "residue_qty"
        case policyID = "policy_id"
    }
}

// MARK: - IndexBanner
struct IndexBanner: Codable {
    let clickType: Int
    let thumbnail: String
    let subTitle, propaganda, title, type: String
    let url: String
    let content: String
    let path: String
    let adID, companyInfoID: Int
    let clickParam: String
    let webTitleType: String?
    let mainTitle, desc: String

    enum CodingKeys: String, CodingKey {
        case clickType = "click_type"
        case thumbnail
        case subTitle = "sub_title"
        case propaganda, title, type, url, content, path
        case adID = "ad_id"
        case companyInfoID = "company_info_id"
        case clickParam = "click_param"
        case webTitleType = "web_title_type"
        case mainTitle = "main_title"
        case desc
    }
}

// MARK: - IndexBrand
struct IndexBrand: Codable {
    let companyInfoID: Int
    let brandName: String
    let brandLogo: String
    let brandType: String
    let brandID: Int

    enum CodingKeys: String, CodingKey {
        case companyInfoID = "company_info_id"
        case brandName = "brand_name"
        case brandLogo = "brand_logo"
        case brandType = "brand_type"
        case brandID = "brand_id"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
