import Foundation

struct Job: Decodable {
    let id: String?
    let createdAt: String?
    let title: String?
    let location: String?
    let type: String?
    let description: String?
    let howToApply: String?
    let company: String?
    let companyUrl: String?
    let companyLogo: String?
    let url: String?
    
    private enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case howToApply = "how_to_apply"
        case companyUrl = "company_url"
        case companyLogo = "company_logo"
        case id, title, location, type, description, company, url
    }
    
}
