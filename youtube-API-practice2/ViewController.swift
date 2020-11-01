//
//  ViewController.swift
//  youtube-API-practice2
//
//  Created by 洪展彬 on 2020/10/29.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var viedoTitleTF: UITextField!
    @IBOutlet weak var submitBT: UIButton!
    
    var videos = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        fetchVideo(searchTitle: "呱吉")
    }
    
    func fetchVideo(searchTitle: String) {
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(searchTitle)&key=AIzaSyDI0MDJYvL6MxY8sw7aS1wU9vXzk_IC7m4&type=video&maxResults=50".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {

            print("url:25 is invalid")
            return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let searchResult = try? decoder.decode(SearchResult.self, from: data!){
                self.videos = searchResult.items
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            }
        }.resume()
    }
    
    //送資料去下一頁
    @IBSegueAction func showComment(_ coder: NSCoder) -> VideoTableViewController? {
        let controller = VideoTableViewController(coder: coder)
        guard let row = myTableView.indexPathForSelectedRow?.row else { return controller }
        controller?.video = videos[row]
        return controller
    }
    
    @IBAction func submitClick(_ sender: Any) {
        let searchTitle = viedoTitleTF.text ?? ""
        if searchTitle != ""{
            fetchVideo(searchTitle: searchTitle)
            self.title = searchTitle
            viedoTitleTF.text = ""
        }else{
            viedoTitleTF.text = "Please enter correct sentence."
        }
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MyTableViewCell.self)", for: indexPath) as! MyTableViewCell
        
        let video = videos[indexPath.row]
        cell.titleLable.text = video.snippet.title
        
        guard let urlImage = URL(string: video.snippet.thumbnails.high.url) else { return cell }
        
        let task = URLSession.shared.dataTask(with: urlImage) { (data, response, error) in
            guard let data = data else{
                print("data is nil")
                return
            }
            DispatchQueue.main.async {
                cell.videoImage.image = UIImage(data: data)
            }
               
        }
        task.resume()
        return cell
        
    }
    
    
}

extension ViewController: UITableViewDelegate{
    
}
