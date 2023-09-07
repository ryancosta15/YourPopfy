import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var trackArtist: UILabel!

    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var trackDate: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    
    @IBOutlet weak var trackPop: UILabel!
    var track: Track!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trackImageView.contentMode = .scaleAspectFit
        
        trackTitle.text = track.track.name
        trackArtist.text = track.track.artists[0].name
        trackDate.text = track.track.album.release_date
        trackLabel.text = "Album: " + track.track.album.name
        trackPop.text = String(track.track.popularity)
        trackImageView.download(path: track.track.album.images[0].url)
    }
}
