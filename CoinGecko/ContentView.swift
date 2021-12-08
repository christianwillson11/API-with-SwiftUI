//
//  ContentView.swift
//  CoinGecko
//
//  Created by Willson on 05/12/21.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var myData: [CoinData] = []
    
    func fetchData()  {
        let vs_currency = "usd"
        
        let url = "https://coingecko.p.rapidapi.com/coins/markets?vs_currency=\(vs_currency)&page=1&per_page=100&order=market_cap_desc"
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        let header = ["x-rapidapi-host": "coingecko.p.rapidapi.com",
        "x-rapidapi-key": "f4f09eac2fmsh94c15e0aabf4c8ap119874jsn77c16249a0a7"]
        
        request.allHTTPHeaderFields = header
        
        request.httpMethod = "GET"
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "")
            } else {
                self?.parseJSON(coinData: data!)
            }
            
        })
        dataTask.resume()
    }

    func parseJSON(coinData: Data) {
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode([CoinData].self, from: coinData)
            
            DispatchQueue.main.async {
                self.myData = decodeData
            }

        } catch {
            print(error)
            print("Here")
        }
    }
}

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
            
        } else {
            Image("Loading")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                .onAppear {
                    fetchData()
                }
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            self.data = data
            
        })
        task.resume()
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                
                ForEach(viewModel.myData, id: \.self) { data in
                    NavigationLink(
                        destination: DetailView(data: data),
                        label: {
                            HStack {
                                URLImage(urlString: data.image)
                                
                                VStack(alignment: .leading) {
                                    Text(data.name).bold()
                                
                                    Text(String(data.current_price))
                                        
                                    Text(data.symbol)
                                        
                                }
                                .padding(.leading, 20)
                            }
                            .padding(3)
                        })
                        
                }
                
            }
            .navigationTitle("Coin")
            .onAppear {
                viewModel.fetchData()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
