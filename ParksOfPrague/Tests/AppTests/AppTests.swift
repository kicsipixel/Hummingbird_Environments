import Hummingbird
import HummingbirdTesting
import Logging
import XCTest


@testable import App

final class AppTests: XCTestCase {
    struct TestArguments: AppArguments {
        let hostname = "127.0.0.1"
        let port = 0
        let logLevel: Logger.Level? = .trace
        let environment: String = "development"
    }
    
    func testApp() async throws {
        let args = TestArguments()
        let app = try await buildApplication(args)
        try await app.test(.router) { client in
            try await client.execute(uri: "/health", method: .get) { response in
                XCTAssertEqual(response.status, .ok)
            }
        }
    }
    
    func test_create_a_park() async throws {
        let park = TestPark(name: "Letenské sady", coordinates: TestPark.TestCoordinates(latitude: 14.4202892, longitude: 50.0959721))
        
        let args = TestArguments()
        let app = try await buildApplication(args)
        
        try await app.test(.router) { client in
            try await client.execute(uri: "/api/v1/parks", method: .post, headers: [.contentType: "application/json"], body: JSONEncoder().encodeAsByteBuffer(park, allocator: ByteBufferAllocator())) { response in
                XCTAssertEqual(response.status, .ok)
            }
        }
    }
}

extension AppTests {
    struct TestPark: Codable {
        let name: String
        let coordinates: TestCoordinates
        
        struct TestCoordinates: Codable {
            let latitude: Double
            let longitude: Double
        }
    }
}
