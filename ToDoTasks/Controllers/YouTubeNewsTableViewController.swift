import UIKit
import SDWebImage

class YouTubeNewsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var newsViewControllerCoordinator: NewsControllerCoordinator?
    
    //let dataManager = Service2()
    let tableView = UITableView()
    var articles = [Article]()
    var youTubeArticle = [YouTubeArticle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setConstraints()
        
        tableView.register(NewsTableViewCell2.self, forCellReuseIdentifier: "NewsTableViewCell2")
        
        // fetchData()
        fetchDataFromNetworkService()
    }
    
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell2", for: indexPath) as! NewsTableViewCell2
        let articleIndexPath = articles[indexPath.row]
        cell.headerLabel.text = articleIndexPath.title
        cell.contentLabel.text = articleIndexPath.content
        cell.sourceLabel.text = articleIndexPath.author
        
        if let urlToImage = articleIndexPath.urlToImage, let url = URL(string: urlToImage) {
            cell.newsImageView.sd_setImage(with: url, completed: nil)
        } else {
            cell.newsImageView.image = nil // Очистить изображение, если urlToImage отсутствует
        }
        
        return cell
    }
    
    func fetchDataFromNetworkService() {
        let url = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=23ed6969bd05413aa7680d0a492f26e9"
        NetworkService.shared.getData(url: url) { [weak self] result in
            switch result {
            case .success(let welcome):
                // self превращаетс] в опциональный тип когда он weak а значит нужно извлечь опционал либо поставить ? Второй вопрос self здесь относится и к articles и к tableView третий вопрос если мы извлекаем опционал в case .success(let welcome) значит если код не попадет в этот блок то и опциорнал не извлечется?
                guard let self = self else {return}
                self.articles = welcome.articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print("данные успешно загружены в массив articles")
            case .failure(let error): print(error)
            }
        }
    }
}
