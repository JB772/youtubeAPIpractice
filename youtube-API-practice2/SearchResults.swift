
import Foundation

struct SearchResult:Decodable {
    let nextPageToken: String?
    let items: [Item]
}
struct Item: Decodable {
    let id : Id
    
    struct Id: Decodable {
        let videoId: String
    }
    let snippet: Snippet
    
    struct Snippet: Decodable {
        let publishedAt: Date?
        let channelId: String
        let title: String
        let thumbnails: Thumbnails
        struct Thumbnails: Decodable {
            let high: HighUrl
            
            struct HighUrl: Decodable {
                let url: String
                let width: Int
                let height: Int
            }
        }
    }
   
    

    
}
