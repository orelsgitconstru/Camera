
import Network
import RxSwift

public struct Camera {
    
    public static var shared = Camera()
    private var interactor: CameraInteractor = .shared
    
    func takePicture() -> Single<Capture?>? {
        return interactor.takePicture()
    }
    
    func getCameraState() -> Single<State?>? {
        return interactor.getCameraState()
    }
    
    func setImageCaptureMode() -> Completable{
        return interactor.setImageCaptureMode()
    }
    
    private init() {}

}
