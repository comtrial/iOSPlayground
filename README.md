iOS Utility 를 테스트 하는 저장소



# WidgetWithDeeplink

## Overiveiew

Widget 을 통한 앱 진입 화면 전환을 위해 

1. Widget
2. Widget - onclik Link 연결
3. Deeplink 
4. Deeplink - Scendelegate 에서 앱 진입점 분기
5. TODO

를 구현한 기능 테스트 입니다. 
<p align="center">
	<img src=https://user-images.githubusercontent.com/67617819/190979898-3e134b3d-475c-4fea-8ad1-4850fc44ec34.gif width="20%" height="20%">
</p>


### 1. Widget

### 2. Widget - onclik Link 연결

Widget 을 통한 앱 전환은 두 가지 방식으로 구현할 수 있다. 

1. 위젯 자체의 클릭을 통한 앱 진입

1. 위젯 내부의 버튼들을 통한 다수의 앱 진입 구현

해당 방식은 Widget의 사이즈에 따라 제약이 있다. 두개 이상의 분기를 구현하고자 하는 경우 Widgetsize 를 medium, large 로만 구현이 가능하다. 

```swift
@main
struct WidgetWithDeeplink_widget: Widget {
    let kind: String = "WidgetWithDeeplink_widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetWithDeeplink_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium]) // 해당 부분에서 Widgetsize setup
    }
}
```

small 사이즈로 구현 할 경우 버튼에 따라 다른 분기점을 만들어 주어도 위의 1. 내용의 앱 진입으로만 작동하게 된다. 

onclick 을 통한 앱 진입은 Widget 자체도 swiftUI 로 구현되어 있기에  `Link(destination: URL(string: “Deeplink URL”)` 로 구현되며, 아래에서 구현한 Deeplink URL 로의 진입점을 잡아주게 된다.   

### 3. Deeplink

### 4. Deeplink - Scendelegate 에서 앱 진입점 분기

#### **In SceneDelegate scen 함수 오버로딩**

Scenedelegate 에서 구현 이 전에 함수의 오버로딩에 대해서 잠깐 정리하자면, 

swift 는 함수의 오버로딩 (Overlading → not Override) 이 가능하다. 

함수의 오버로딩이 가능하다는 말은 아래의 함수가 서로 다른 함수로 인식한다는 것이며, 

이는 swift 가 함수를 식별시, 함수의 파라미터 타입, 리턴 타입을 고려하여 인식한다는 것이다.

이로 인해 같은 기능을 하는 함수이나, 파라미터의 타입이 다르거나(int, Double ..), 리턴 타입이 다른 경우의 함수 구현이 보다 가시적으로 같은 이름을 갖는 함수로 구현이 가능하다는 점이다. 

```swift
func sum() { }
func sum(n: Int) { }
func sum() -> Int { return 0 }
```

위의 개념이 SceneDelegate 에서 적용되는 부분은 

- 앱이 일반적으로 런칭될 경우의 func scen()
- 앱이 Deeplink 를 타고 런칭 될 경우의 func scen()

을 들어오는 파라미터에 따라 다르게 작동하는 scene 함수를 overloading 으로 구현하게 된다. 

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
				// ... 앱이 일반적인 런칭으로 들어올 경우 Application LifeCycle 정의 
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
				// ... Deeplink 로 들어올 경우 Application LifeCycle 정의 
    }
}
```

#### **Deeplink** SceneDelegate **scene function**

파라미터에 따라 Deeplink 온 경우 아래의 scene 함수가 호출 되기에, 해당 함수에서 

Deeplink 로 진입한 경우의 schema check, host check, parameter check 등의 원하는 처리를 해주면 된다. 

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
				// ... 앱이 일반적인 런칭으로 들어올 경우 Application LifeCycle 정의 
    }
    
		// MARK: Deeplink Scene 
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
				guard let url = URLContexts.first?.url else { return }
        
        // 해당 scheme과 host를 가지고 있는지 파악
        guard url.scheme == "Deeplink-test", url.host == "widget" else { return }

        // 원하는 query parameter가 있는지 파악
        let urlString = url.absoluteString
        guard urlString.contains("mode") else { return }

        let components = URLComponents(string: url.absoluteString)
        let urlQueryItems = components?.queryItems ?? [] // [mode=text]

        var dictionaryData = [String: String]()
        urlQueryItems.forEach { dictionaryData[$0.name] = $0.value }

        guard let mode = dictionaryData["mode"] else { return }
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = ViewController(deeplinkParam: mode)
            self.window = window
            window.makeKeyAndVisible()
            
        } else { return }
    }
}
```

### 5. TODO

위의 구현이 가지는 한계는 앱 진입의 분기가 앱이 Background 에서 살아있어야 위의 분기가 가능하다는 점이다. 

즉, 앱을 실행시켜 백그라운드에 살아있을 경우에만 위의 2.2 의 다수의 앱 진입이 가능하며, 앱이 실행되지 않은 경우 클릭시 2.1 의 위젯 자체의 클릭을 통한 앱 전환으로 실행되게 된다.

