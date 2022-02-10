
import Network
import RxSwift

public struct Camera {
    
    public static var shared = Camera()
    private var interactor: CameraInteractor = .shared
    
    public func takePicture() -> Single<CameraResponse?> {
        return interactor.takePicture()
    }
    
    public func getCameraState() -> Single<CameraResponse?> {
        return interactor.getCameraState()
    }
    
    public func setImageCaptureMode() -> Completable{
        return interactor.setImageCaptureMode()
    }
    
    private init() {}

}
