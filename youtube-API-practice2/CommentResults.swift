//
//  videoComments.swift
//  youtube-API-practice2
//
//  Created by 洪展彬 on 2020/10/30.
//

import Foundation

struct CommentResult: Decodable {
    let nextPageToken: String?
    let pageInfo: PageInfo
    let items: [CommentItem]
    struct PageInfo: Decodable {
        let totalResults: Int
        let resultsPerPage: Int
    }
}
struct CommentItem: Decodable {
    let snippet: CommentSnippet
    let replies: Replies?
    struct CommentSnippet: Decodable {
        let topLevelComment: TopLevelComment
    }
    struct TopLevelComment: Decodable {
        let snippet: TopLevelCommentSnippet
        struct TopLevelCommentSnippet: Decodable {
            let textOriginal:String
            let authorDisplayName: String
            let authorProfileImageUrl: String
            let likeCount: Int
            let updatedAt: Date
        }
    }
    struct Replies: Decodable{
        let comments: [TopLevelComment]
    }
}
