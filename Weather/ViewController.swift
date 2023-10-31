//
//  ViewController.swift
//  Weather
//
//  Created by Arina Momot on 31.10.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var temperatureValue: UILabel!
    @IBOutlet var getWeatherButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherButton.addTarget(self, action: #selector(didTapGetWeatherButton), for: .touchUpInside)
    }

    @objc func didTapGetWeatherButton() {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true"
        let url = URL(string: urlString)! // Optional by default, so need !
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    self.temperatureValue.text = "\(weather.currentWeather.temperature)°"
                } // transfer to main thread
            } else {
                print("Fail!")
            }
        }
        task.resume() // start
    }
}

