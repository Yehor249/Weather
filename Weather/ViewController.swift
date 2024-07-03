import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var weatherLable: UILabel!
    @IBOutlet var getWeatherButton: UIButton!
    
    var locationManager: CLLocationManager!
    var currentLatitude: Double?
    var currentLongitude: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        getWeatherButton.addTarget(self, action: #selector(didTapGetWaetherButton), for: .touchUpInside)
    }

    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLatitude = location.coordinate.latitude
            currentLongitude = location.coordinate.longitude
            print("Found user's location: \(location)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }

    @objc func didTapGetWaetherButton() {
        guard let latitude = currentLatitude, let longitude = currentLongitude else {
            print("Location not available")
            return
        }
        
<<<<<<< Updated upstream
        // в ссылке сделлать интерполяцию
        let latitude = 52.52
        let longitude = 13.41

=======
        print(latitude)
        
>>>>>>> Stashed changes
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
