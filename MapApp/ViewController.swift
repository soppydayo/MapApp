import UIKit
// 2つimportする
import MapKit
import CoreLocation

// CLLocationManagerDelegateを継承する
class ViewController: UIViewController, CLLocationManagerDelegate {
    // storyboardから接続する
    @IBOutlet weak var mapView: MKMapView!
    // locationManagerを宣言する
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ロケーションマネージャーのセットアップ
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        
        // 現在地に照準を合わす
        // 0.01が距離の倍率
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        // mapView.userLocation.coordinateで現在地の情報が取得できる
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: span)
        // ここで照準を合わせている
        mapView.region = region
    }
}
    
    // 許可を求めるためのdelegateメソッド
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            // 許可されてない場合
        case .notDetermined:
            // 許可を求める
            manager.requestWhenInUseAuthorization()
            // 拒否されてる場合
        case .restricted, .denied:
            // 何もしない
            break
            // 許可されている場合
        case .authorizedAlways, .authorizedWhenInUse:
            // 現在地の取得を開始
            manager.startUpdatingLocation()
            break
        default:
            break
        }
    }

