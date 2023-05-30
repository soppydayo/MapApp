import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var isMapDelegateSet = false // mapViewのdelegate設定のフラグ
    var isFirstLoad = true // 画面が初回ロードされたかのフラグ
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ロケーションマネージャーの初期化と設定
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        // ユーザーからの位置情報の利用許可を要求
        locationManager.requestWhenInUseAuthorization()
        
        mapView.showsUserLocation = true // 現在位置を表示する設定
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // mapViewのdelegateを設定
        mapView.delegate = self
        isMapDelegateSet = true
        
        // 初回ロード時にのみ地図の表示領域を更新
        if isFirstLoad {
            locationManager.startUpdatingLocation()
            isFirstLoad = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // mapViewのdelegateを解除
        mapView.delegate = nil
        isMapDelegateSet = false
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
            
            // mapViewのdelegateが設定されている場合のみ地図の表示領域を更新
            if isMapDelegateSet {
                mapView.region = region
                locationManager.stopUpdatingLocation() // 初回ロード時に位置情報の更新を停止
            }
        }
    }

    
    
    func presentPickerViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pickerViewController = storyboard.instantiateViewController(withIdentifier: "presentPickerViewController") as! presentPickerViewController
        
        
        navigationController?.pushViewController(pickerViewController, animated: true)
    }
}
