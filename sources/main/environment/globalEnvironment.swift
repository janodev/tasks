
// Set true to replace network operations with mocks that return json files
private let useNetworkMocks = false

// Set true to attempt to read the API key and company from a plist configuration file
private let useConfiguration = true

public var environment: Environment = {
    let configuration: Configuration? = useConfiguration ? PlistConfiguration(forResource: "configuration", ofType: "plist") : nil
    let env = AppEnvironment(configuration: configuration)
    if useNetworkMocks {
        env.authenticatingClient = MockedAuthenticatingClient()
        env.teamworkClient = MockedTeamworkClient()
    }
    return env
}()
