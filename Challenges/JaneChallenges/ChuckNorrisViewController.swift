//
//  ChuckNorrisViewController.swift
//  Challenges
//
//  Created by Gordon Tucker on 3/2/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import UIKit

// String helper found from stack overflow
extension String {
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func endIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

class ChuckNorrisViewController: UIViewController {

    struct JokeWrapper: Codable {
        var type: String
        var value: Joke
    }
    
    struct Joke: Codable {
        var id: Int
        var joke: String
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    func addShadow(toLabel label: UILabel) {
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 1.5
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.masksToBounds = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.topLabel.text = "Loading..."
        self.bottomLabel.text = "Something Chuck Norris never has to do"
        
        self.addShadow(toLabel: self.topLabel)
        self.addShadow(toLabel: self.bottomLabel)
        
        self.moveNext()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    @IBAction func tapped(_ sender: Any) {
        self.moveNext()
    }
    
    func moveNext() {
        self.imageView.image = #imageLiteral(resourceName: "chuck")
        self.topLabel.text = "Loading..."
        self.bottomLabel.text = "Something Chuck Norris never has to do"
        
        var newTop: String?
        var newBottom: String?
        var newImage: UIImage?
        
        let checkIfDone = {
            guard let top = newTop, let bottom = newBottom, let image = newImage else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
                self.topLabel.text = top
                self.bottomLabel.text = bottom
            }
        }
        
        self.downloadImage { (image) in
            newImage = image
            checkIfDone()
        }
        
        self.downloadJoke(complete: { (top, bottom) in
            newTop = top
            newBottom = bottom
            checkIfDone()
        })
    }
    
    func downloadImage(complete: @escaping (UIImage?) -> Void) {
        let imageUrl = "https://picsum.photos/\(Int(self.view.bounds.width * 2))/\(Int(self.view.bounds.height * 2))/?random"
        
        URLSession.shared.dataTask(with: URL(string: imageUrl)!) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else { return complete(nil) }
            complete(image)
        }.resume()
    }
    
    func downloadJoke(complete: @escaping (String, String) -> Void) {
        let jokeUrl = "http://api.icndb.com/jokes/random"
        URLSession.shared.dataTask(with: URL(string: jokeUrl)!) { (data, response, error) in
            guard let data = data else { return complete("", "") }
            do {
                let fullJoke = try JSONDecoder().decode(JokeWrapper.self, from: data)
                let joke = fullJoke.value.joke.replacingOccurrences(of: "&quot;", with: "'")
                if let index = joke.index(of: "? ") ?? joke.index(of: ". ") {
                    complete(joke.substring(to: index), joke.substring(from: joke.index(after: index)).trimmingCharacters(in: .whitespaces))
                } else {
                    complete("", joke)
                }
            } catch {
                print("Failed to parse joke: \(error)")
            }
            
        }.resume()
    }
}
