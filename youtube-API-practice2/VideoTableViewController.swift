//
//  VideoTableViewController.swift
//  youtube-API-practice2
//
//  Created by 洪展彬 on 2020/10/30.
//

import UIKit

class VideoTableViewController: UITableViewController {
    
    var video: Item?
    var comments = [CommentItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = video?.snippet.title
        guard let videoId = video?.id.videoId,
              let url = URL(string: "https://www.googleapis.com/youtube/v3/commentThreads?part=snippet,replies&videoId=\(videoId)&key=yourAPI-KEY") else {
            print("url is invalid")
            return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let data = data,
               let commentResult = try? decoder.decode(CommentResult.self, from: data){
                self.comments = commentResult.items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }.resume()
    }

    //帶資料去下一頁
    @IBSegueAction func showReplies(_ coder: NSCoder) -> ReplyViewController? {
        let controller = ReplyViewController(coder: coder)
        guard let row = tableView.indexPathForSelectedRow?.row else {
            print("row is nil")
            return controller }
        controller?.comment = comments[row]

//        controller?.replies = comments[(row)!].replies
//        controller?.replies = comments[row!].replies
        
        
        return controller
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(VideoTableViewCell.self)", for: indexPath) as! VideoTableViewCell
        let comment = comments[indexPath.row]
        cell.authorName.text = comment.snippet.topLevelComment.snippet.authorDisplayName
        cell.commentTextView.text = comment.snippet.topLevelComment.snippet.textOriginal
        cell.likeCountLabel.text = String("👍\t\(comment.snippet.topLevelComment.snippet.likeCount)")
        
        if comment.replies != nil{
            cell.repliesButton.isEnabled = true
            cell.repliesButton.tintColor = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(1), alpha: CGFloat(1))
        }
        
        
        
        cell.authorDate.text = date2String(comment.snippet.topLevelComment.snippet.updatedAt)
        
        guard let authorUrl = URL(string: "\(comment.snippet.topLevelComment.snippet.authorProfileImageUrl)") else {
                print("ImageURL is invalid.")
                return cell }
        URLSession.shared.dataTask(with: authorUrl) { (data, response, error) in
            guard let data = data else{
                print("data is nil")
                return
            }
            DispatchQueue.main.async {
                cell.authorImage.image = UIImage(data: data)
            }
        }.resume()

        return cell
    }

    func date2String (_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let dateStr = formatter.string(from: date)
        return dateStr
    }
}
