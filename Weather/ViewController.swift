//
//  ViewController.swift
//  Weather
//
//  Created by Yegor Niedov on 26.06.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var weatherLable: UILabel!
    @IBOutlet var getWeatherButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherButton.addTarget(self , action: #selector(didTapGetWaetherButton), for: .touchUpInside)
    }

    @objc func didTapGetWaetherButton() {
        
        // в ссылке сделлать интерполяцию
        let latitude = 52.52
        let longitude = 13.41

        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    self.weatherLable.text = "\(weather.currentWeather.temperature)"
                }
            } else {
                print("Fail")
            }
        }
        task.resume()
    }
}

