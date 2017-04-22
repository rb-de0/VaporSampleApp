import PackageDescription

let package = Package(
    name: "VaporSampleApp",
    targets: [
        Target(name: "App"),
        Target(name: "Run", dependencies: ["App"]),
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", Version(2,0,0, prereleaseIdentifiers: ["beta"])),
        .Package(url: "https://github.com/vapor/fluent-provider.git", Version(1,0,0, prereleaseIdentifiers: ["beta"])),
        .Package(url: "https://github.com/vapor/fluent.git", Version(2, 0, 0, prereleaseIdentifiers: ["beta"])),
        .Package(url: "https://github.com/vapor/auth.git", Version(1, 0, 0, prereleaseIdentifiers: ["beta"])),
        .Package(url: "https://github.com/vapor/auth-provider.git", Version(1, 0, 0, prereleaseIdentifiers: ["beta"])),
        .Package(url: "https://github.com/vapor/leaf-provider.git", Version(1, 0, 0, prereleaseIdentifiers: ["beta"])),
        .Package(url: "https://github.com/vapor/redis-provider.git", Version(2, 0, 0, prereleaseIdentifiers: ["beta"]))
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
    ]
)

