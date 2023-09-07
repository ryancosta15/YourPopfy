import UIKit

class TracksViewController: UIViewController {
    private var tracks: [Track] = [
    ]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Musicas Curtidas"
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        addViewsInHierarchy()
        setupConstraints()
        fetchRemoteTracks()
    }
    
    private func addViewsInHierarchy(){
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchRemoteTracks(){

        
        let headers = [
            "X-RapidAPI-Key": "975819487cmsh43156e0c426782ap15bab5jsnf44c61f1cc4d",
            "X-RapidAPI-Host": "spotify23.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://spotify23.p.rapidapi.com/playlist_tracks/?id=4DhWXA3sY6lnrlgGfipP1G&offset=0&limit=100")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){data, response, error in
            if error != nil {return}
            
            guard let tracksData = data else {return}
            
            let decoder = JSONDecoder()
            guard let remoteAlbums = try? decoder.decode(RemoteAlbum.self, from: tracksData) else {print("Limamei")
                return}
            
            self.tracks = remoteAlbums.items
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
           // self.tracks.name = remoteAlbums.items.track.name
            //self.tracks.artist = remoteAlbums.items.track.artists.name
           // self.tracks.popularity = remoteAlbums.items.track.popularity
           // self.tracks.album = remoteAlbums.items.tracks.album.name
            //self.tracks.release_date = remoteAlbums.items.tracks.album.release_date
           // self.tracks.url = remoteAlbums.items.tracks.album.images.url
           // print(remoteAlbums)
   //         print(String(data: tracksData, encoding: .utf8) as Any)
        }
        task.resume()
    }
}

extension TracksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TrackCell()
        let track = tracks[indexPath.row]
        cell.configure(track: track)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Detail", bundle: Bundle(for: DetailViewController.self))
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "Detail")as! DetailViewController
        detailViewController.track = tracks[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
    
