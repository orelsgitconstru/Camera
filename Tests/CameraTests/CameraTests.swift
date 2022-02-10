import XCTest
@testable import Camera

final class CameraTests: XCTestCase {
    func testExample() throws {
        let cameraStateSingle = Camera.shared.getCameraState()
        let cameraTakePictureSingle = Camera.shared.takePicture()
        XCTAssertNotNil(cameraStateSingle)
        XCTAssertNotNil(cameraTakePictureSingle)
    }
}
