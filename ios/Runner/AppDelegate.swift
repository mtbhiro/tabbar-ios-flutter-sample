import SwiftUI
import Flutter

// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }

class FlutterDependencies: ObservableObject {
  let myFlutterEngine = FlutterEngine(name: "myFlutterEngine")

  init() {
    // Prepare a Flutter engine in advance.
    myFlutterEngine.run()
  }
}

@main
struct MyApp: App {

  @StateObject var flutterDependencies = FlutterDependencies()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(flutterDependencies)
    }
  }
}

struct ContentView: View {
  @EnvironmentObject var flutterDependencies: FlutterDependencies

  var body: some View {
    TabView {
        Text("iOSネイティブの画面")
            .tabItem {
                VStack {
                    Image(systemName: "a")
                    Text("発見")
                }
            }
            .tag(1)
        StudyView(flutterEngine: flutterDependencies.myFlutterEngine)
            .tabItem {
                VStack {
                    Image(systemName: "bold")
                    Text("進路研究")
                }
            }
            .tag(2)
    }
  }
}

struct StudyView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    let flutterEngine: FlutterEngine

    func makeUIViewController(context: Context) -> UIViewControllerType {
        let flutterViewController = FlutterViewController(
          engine: flutterEngine,
          nibName: nil,
          bundle: nil)
        flutterViewController.isViewOpaque = false
        return flutterViewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }

//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }

//    class Coordinator {
//
//    }
}
