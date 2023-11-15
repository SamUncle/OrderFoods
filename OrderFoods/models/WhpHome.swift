// This file was generated from JSON Schema using quicktype, do not modify it directly.https://app.quicktype.io/
// To parse the JSON, add this file to your project and do:
//
//   let whpHome = try? JSONDecoder().decode(WhpHome.self, from: jsonData)

import Foundation

// MARK: - WhpHome
struct WhpHome: Codable {
    let indexBannerTop: [IndexBanner]
    let categoryMap: CategoryMap
    let keyWords: [String]
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






