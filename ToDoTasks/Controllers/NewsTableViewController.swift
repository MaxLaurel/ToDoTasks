import UIKit
import SDWebImage

class NewsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //weak var newsViewControllerCoordinator: NewsControllerCoordinator?
    let tableView = UITableView()
    var youTubeArticle = [Article]()
    let networkManager: NetworkRequestPerforming
    let imageFetcher: URLtoImageFetcherProtocol
    var onFinish: (() -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(networkManager: NetworkRequestPerforming, imageFetcher: URLtoImageFetcherProtocol) {
        self.networkManager = networkManager
        self.imageFetcher = imageFetcher
        super.init(nibName: nil, bundle: nil) // Вызов родительского инициализатора
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setConstraints()
        
        tableView.register(YouTubeAPITableViewCell.self, forCellReuseIdentifier: "YouTubeAPITableViewCell")
        
        getDataFromYouTubeAPI()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youTubeArticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YouTubeAPITableViewCell", for: indexPath) as! YouTubeAPITableViewCell
        
        let articleObject = youTubeArticle[indexPath.row]//берем каждый отдельный обьект массива по его индекс паф
        cell.headerLabel.text = articleObject.title
        cell.contentLabel.text = articleObject.content
        cell.sourceLabel.text = articleObject.author
        
        //если нужно просто кешировать без заморочек
        //        if let urlToImage = articleIndexPath.urlToImage, let url = URL(string: urlToImage) {
        //            cell.newsImageView.sd_setImage(with: url, completed: nil)
        //        } else {
        //            cell.newsImageView.image = nil
        //        }
        
        if let urlToImage = articleObject.urlToImage, let url = URL(string: urlToImage) {//когда делаем обычный запрос в сеть то сразу приходят только текст, картинки должны запрашиваться отдельным сетевым запросом, так как они лежат на сервере  в формате строки, и нам нужно сначала преобразовать строку как URL ссылку а потом с этой ссылкой сделать запрос картинки
            
            let currentIndexPath = indexPath//получаем текущий индекспаф
            
            // Начинаем загрузку нового изображения
            
            
            cell.newsImageView.image = UIImage(named: "Placehold")
            
            cell.imageLoadingTask = imageFetcher.fetchImage(url: url) { result in
                DispatchQueue.main.async {
                    // Проверяется, что изображение подгружается именно для текущего индекса ячейки, а не для старой, отменённой задачи.(без этого PrepareForReuse не помог)
                    if currentIndexPath == tableView.indexPath(for: cell) {
                        switch result {
                        case .success(let image):
                            cell.newsImageView.image = image
                        case .failure:
                            cell.newsImageView.image = UIImage(named: "Placehold")//если загрузить не получилось используем болванку
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func getDataFromYouTubeAPI() {
        Log.info("Fetching data from YouTube API...")
        
        networkManager.performForegroundRequest(viewController: self) { (result: Result<[Article], Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.youTubeArticle = data
                    self.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    Log.error("Block completion from performForegroundRequest couldn't handle: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension NewsTableViewController {//это расширение для того чтобы можно было удалять координатор этого контроллера через родительский координатор
    
    override func viewWillDisappear(_ animated: Bool) {
        if isMovingFromParent || isBeingDismissed { //когда вью уходит с экрана модально или удаляется из стека:
            onFinish?() //координатор загружает реализацию клоужера сюда в вьюконтроллер// был установлен метод где родительский координатор удаляет дочерний координатор их массива координаторов, таким образом убирается сильная ссылка на координатор
        }
    }
}
