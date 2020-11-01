//
//  ReplyViewController.swift
//  youtube-API-practice2
//
//  Created by 洪展彬 on 2020/10/31.
//

import UIKit

class ReplyViewController: UIViewController {

    @IBOutlet weak var replyTableView: UITableView!
    
    var comment: CommentItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        replyTableView.delegate = self
        replyTableView.dataSource = self
        
    }
}

extension ReplyViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataCount = comment?.replies?.comments.count else { return 0 }
        return dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ReplyTableViewCell.self)", for: indexPath) as! ReplyTableViewCell
        let reply = comment?.replies?.comments[indexPath.row]
        cell.authorName.text = reply?.snippet.authorDisplayName
        cell.editDateLabel.text = date2String((reply?.snippet.updatedAt)!)
        cell.replyTextView.text = reply?.snippet.textOriginal
        cell.likeCountLabel.text = String("👍\t\((reply?.snippet.likeCount)!)")
        
        guard let replyImageUrl = URL(string: (reply?.snippet.authorProfileImageUrl)!) else {
            print("replyImageUrl is nil.")
            return cell }
        
        let task = URLSession.shared.dataTask(with: replyImageUrl) { (data, response, error) in
            if let data = data{
                DispatchQueue.main.async {
                    cell.authorImage.image = UIImage(data: data)
                }
            }
        }
        task.resume()
        
        return cell
    }
    
    func date2String(_ date:Date, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formattor = DateFormatter()
        formattor.locale = Locale.init(identifier: "zh_CN")
        formattor.dateFormat = dateFormat
        
        return formattor.string(from: date)
    }
}

extension ReplyViewController: UITableViewDelegate{
    
}
