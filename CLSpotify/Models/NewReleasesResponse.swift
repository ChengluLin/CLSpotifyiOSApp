//
//  NewReleasesResponse.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/4/8.
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: [AlbumsResponse]
}

struct AlbumsResponse: Codable {
    let items: [Album]
}

struct Album: Codable {
    let album_type: String
    let available_markets: [String]
    let id: String
    let image: [APIImage]
    let name: String
}


//
//{
//"album_type" = single;
//artists =                 (
//                {
//"external_urls" =                         {
//    spotify = "https://open.spotify.com/artist/77AiFEVeAVj2ORpC85QVJs";
//};
//href = "https://api.spotify.com/v1/artists/77AiFEVeAVj2ORpC85QVJs";
//id = 77AiFEVeAVj2ORpC85QVJs;
//name = "Steve Aoki";
//type = artist;
//uri = "spotify:artist:77AiFEVeAVj2ORpC85QVJs";
//},
//                {
//"external_urls" =                         {
//    spotify = "https://open.spotify.com/artist/5pXe6yFchq1oyYK3rq2A8i";
//};
//href = "https://api.spotify.com/v1/artists/5pXe6yFchq1oyYK3rq2A8i";
//id = 5pXe6yFchq1oyYK3rq2A8i;
//name = KIDDO;
//type = artist;
//uri = "spotify:artist:5pXe6yFchq1oyYK3rq2A8i";
//}
//);
//"external_urls" =                 {
//spotify = "https://open.spotify.com/album/10qvBn2MB8C4qGdj2aSymU";
//};
//href = "https://api.spotify.com/v1/albums/10qvBn2MB8C4qGdj2aSymU";
//id = 10qvBn2MB8C4qGdj2aSymU;
//images =                 (
//                {
//height = 300;
//url = "https://i.scdn.co/image/ab67616d00001e02fd020e06c84159fa67cb0d86";
//width = 300;
//},
//                {
//height = 64;
//url = "https://i.scdn.co/image/ab67616d00004851fd020e06c84159fa67cb0d86";
//width = 64;
//},
//                {
//height = 640;
//url = "https://i.scdn.co/image/ab67616d0000b273fd020e06c84159fa67cb0d86";
//width = 640;
//}
//);
//name = "Drive ft. KIDDO";
//"release_date" = "2024-04-05";
//"release_date_precision" = day;
//"total_tracks" = 1;
//type = album;
//uri = "spotify:album:10qvBn2MB8C4qGdj2aSymU";
//}
