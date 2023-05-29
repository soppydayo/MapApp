import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ロケーションマネージャーの初期化と設定
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        // ユーザーからの位置情報の利用許可を要求
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
    }
    
    // 位置情報の利用許可が変更された時に呼ばれるメソッド
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()  // 位置情報の更新を開始
        default:
            break
        }
    }
    
    // 位置情報が更新された時に呼ばれるメソッド
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.region = region  // 地図の表示領域を更新
        }
    }
    
    
    func presentPickerViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pickerViewController = storyboard.instantiateViewController(withIdentifier: "presentPickerViewController") as! presentPickerViewController
        

        navigationController?.pushViewController(pickerViewController, animated: true)
    }

    

}
