import UIKit
import SDWebImage

class YouTubeNewsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var newsViewControllerCoordinator: NewsControllerCoordinator?
    
    //let dataManager = Service2()
    let tableView = UITableView()
<<<<<<< HEAD
    //var youTubeArticle = [Article]()
    var youTubeArticle = [YouTubeArticle]()
=======
    //var youTubeArticle = [String: Article]()
    var youTubeArticle = [Article]()
>>>>>>> tik_2-NetworkSession
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setConstraints()
        
<<<<<<< HEAD
        tableView.register(NewsTableViewCell2.self, forCellReuseIdentifier: "NewsTableViewCell2")
        
        //fetchDataFromNetworkService()
        getDataFromYouTubeAPI()
    
=======
        tableView.register(YouTubeAPITableViewCell.self, forCellReuseIdentifier: "YouTubeAPITableViewCell")
        
        //fetchDataFromNetworkService()
        
        getDataFromYouTubeAPI()
>>>>>>> tik_2-NetworkSession
    }
    
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youTubeArticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
<<<<<<< HEAD
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell2", for: indexPath) as! NewsTableViewCell2
=======
        let cell = tableView.dequeueReusableCell(withIdentifier: "YouTubeAPITableViewCell", for: indexPath) as! YouTubeAPITableViewCell
        
        //когда модель ожидалась массивом то работал этот код
>>>>>>> tik_2-NetworkSession
        let articleIndexPath = youTubeArticle[indexPath.row]
        cell.headerLabel.text = articleIndexPath.title
        cell.contentLabel.text = articleIndexPath.content
        cell.sourceLabel.text = articleIndexPath.author
        
<<<<<<< HEAD
=======
        //        let key = Array(youTubeArticle.keys)[indexPath.row] // получаем ключ по индексу
        //           let article = youTubeArticle[key] // получаем статью по ключу
        //        cell.headerLabel.text = article?.title
        //        cell.contentLabel.text = article?.content
        //        cell.sourceLabel.text = article?.author
        
>>>>>>> tik_2-NetworkSession
        if let urlToImage = articleIndexPath.urlToImage, let url = URL(string: urlToImage) {
            cell.newsImageView.sd_setImage(with: url, completed: nil)
        } else {
            cell.newsImageView.image = nil // Очистить изображение, если urlToImage отсутствует
        }
        
        return cell
    }
    
<<<<<<< HEAD
    func fetchDataFromNetworkService() {
        let url = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=23ed6969bd05413aa7680d0a492f26e9"
        NetworkService.shared.getData(url: url) { [weak self] result in
            switch result {
            case .success(let welcome):
                // self превращаетс] в опциональный тип когда он weak а значит нужно извлечь опционал либо поставить ? Второй вопрос self здесь относится и к articles и к tableView третий вопрос если мы извлекаем опционал в case .success(let welcome) значит если код не попадет в этот блок то и опциорнал не извлечется?
                guard let self = self else {return}
                // self.youTubeArticle = welcome.articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print("данные успешно загружены в массив articles")
            case .failure(let error): print(error)
            }
        }
    }
        func getDataFromYouTubeAPI() {
            YouTubeAPIClient.shared.getVideoFromAPI { [weak self] articles in
                guard let articles = articles else { return }
                self?.youTubeArticle = articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
=======
    
    
    // func fetchDataFromNetworkService() {
    //        let url = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=23ed6969bd05413aa7680d0a492f26e9"
    //        NetworkService.shared.getData(url: url) { [weak self] result in
    //            switch result {
    //            case .success(let welcome):
    //                // self превращаетс] в опциональный тип когда он weak а значит нужно извлечь опционал либо поставить ? Второй вопрос self здесь относится и к articles и к tableView третий вопрос если мы извлекаем опционал в case .success(let welcome) значит если код не попадет в этот блок то и опциорнал не извлечется?
    //                guard let self = self else {return}
    //                // self.youTubeArticle = welcome.articles
    //                DispatchQueue.main.async {
    //                    self.tableView.reloadData()
    //                }
    //                print("данные успешно загружены в массив articles")
    //            case .failure(let error): print(error)
    //            }
    //        }
    //  }
    func getDataFromYouTubeAPI() {
       Log.info("Fetching data from YouTube API...")
        DINetworkContainer.shared.foregroundNetworkManager.performForegroundRequest(viewController: self) { (result: Result<[Article], Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
               //     Log.info("Response success data")
                    self.youTubeArticle = data
                    self.tableView.reloadData()
                }
            case .failure(let error):
           
                DispatchQueue.main.async {
                Log.error("Request failed with error")
>>>>>>> tik_2-NetworkSession
                }
            }
        }
    }
<<<<<<< HEAD
=======
    
    deinit {
       Log.info("YouTubeNewsViewController was deallocated")
    }
}
>>>>>>> tik_2-NetworkSession

