import Foundation

struct RemoteAlbum: Decodable{
    let items : [Track]
}
struct Tracks :Decodable{
    let name: String
    let popularity: Int
    let artists: [Artists]
    let album: Album
}
struct Artists:Decodable{
    let name: String
}
struct Album:Decodable{
    let name: String
    let release_date: String
    let images : [Images]
}
struct Images:Decodable{
    let url:String
}
