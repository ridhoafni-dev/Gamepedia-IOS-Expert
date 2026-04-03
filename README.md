# Gamepedia iOS Expert

[![Codemagic build status](https://api.codemagic.io/apps/69cf9432c67af7fcb8ff114c/ios-project-debug/status_badge.svg)](https://codemagic.io/app/69cf9432c67af7fcb8ff114c/ios-project-debug/latest_build)

A modern, feature-rich iOS application for discovering and exploring video games. Built with **SwiftUI**, **Combine**, and **Clean Architecture** principles, Gamepedia demonstrates advanced iOS development practices with modular design and reactive programming.

## 📱 Overview

**Gamepedia** is an iOS app that integrates with the [RAWG.io Video Games Database API](https://rawg.io/api) to provide comprehensive game discovery and exploration features. The app showcases best practices in modern Swift development with a focus on scalability, testability, and user experience.

### Key Features

✨ **Game Discovery** - Browse games sorted by rating (best to worst) with detailed information  
🔍 **Advanced Search** - Real-time search functionality for games by title and keywords  
📂 **Genre Exploration** - Browse and filter games by genre with visual grid display  
👥 **Developer Browsing** - Discover game developers and their associated titles  
❤️ **Favorites Management** - Save favorite games locally with persistent storage (Realm)  
📊 **Detailed Game Views** - Comprehensive game information including ratings, platforms, and metadata  
📲 **Tab-Based Navigation** - Intuitive tab-based interface (Home, Search, Favorites, Profile)  
🏠 **Offline Support** - Hybrid caching strategy with local-first data access  

## 🏗️ Architecture

Gamepedia follows a **Clean Architecture** pattern with modular design using **Swift Package Manager (SPM)**:

```
Gamepedia-IOS-Expert/
├── Gamepedia/                    # Main app target (Presentation)
│   ├── App/                      # App entry point & DI setup
│   ├── Features/                 # Feature modules (UI & Routing)
│   │   ├── Main/                 # Tab navigation
│   │   ├── GameDetails/          # Game detail feature
│   │   ├── GenreDetail/          # Genre detail feature
│   │   ├── DiscoveryByRating/   # Rating-based discovery
│   │   └── Splash/              # Splash screen
│   └── Core/                     # Utilities, extensions, DI container
│
└── Modules/                      # SPM Feature Modules (Domain + Data)
    ├── Core/                     # Shared abstractions & protocols
    ├── Games/                    # Games feature module
    ├── Genres/                   # Genres feature module
    ├── Developers/              # Developers feature module
    ├── Favorite/                # Favorites feature module
    └── SearchGame/              # Search feature module
```

### Architecture Layers

| Layer | Purpose | Components |
|-------|---------|-----------|
| **Presentation** | UI & Navigation | SwiftUI Views, Presenters, Routers |
| **Domain** | Business Logic | Use Cases (Interactors), Domain Models, Protocols |
| **Data** | Data Access | Repositories, Data Sources (Remote/Local), Entities |

### Design Patterns

- **MVVM-C** - Model-View-ViewModel with Coordinators/Routers
- **Repository Pattern** - Abstract data access logic
- **Dependency Injection** - Loose coupling and testability
- **Reactive Programming** - Combine framework for asynchronous operations
- **Generic Presenter** - Reusable presenter for multiple features
- **Protocol-Based Design** - Type-safe abstractions

## 🛠️ Technology Stack

### Languages & Frameworks
- **Swift 6.2+**
- **SwiftUI** - Declarative UI framework
- **Combine** - Reactive programming framework
- **iOS 16+** (minimum deployment target)

### Dependencies (Swift Package Manager)
| Package | Version | Purpose |
|---------|---------|---------|
| **RealmSwift** | 10.50.0+ | Local data persistence & caching |
| **Alamofire** | 5.2.0+ | HTTP networking & API calls |

### Build & CI/CD
- **Xcode** (latest)
- **CodeMagic** - Automated CI/CD pipeline
- **CocoaPods** - Dependency management

## 🚀 Getting Started

### Prerequisites
- Xcode 14.0 or later
- iOS 16.0 or later
- CocoaPods

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/ridhoafni-dev/Gamepedia-IOS-Expert.git
cd Gamepedia-IOS-Expert
```

2. **Install dependencies (CocoaPods)**
```bash
pod install
```

3. **Open the workspace**
```bash
open Gamepedia.xcworkspace
```

4. **Build & Run**
- Select `Gamepedia` scheme
- Choose your target simulator or device
- Press `Cmd + R` to build and run

## 📊 Data Flow

### Example: Fetch Games

```
HomeView (onAppear)
    ↓
GamePresenter.getGames()
    ↓
GameInteractor.getFewDiscoveryGames()
    ↓
GetGamesRepository
    ├─→ GetGameLocaleDataSource (Local Cache)
    └─→ GetGamesRemoteDataSource (RAWG API)
        ↓
    GameResponse[] (API Response)
        ↓
    GameTransformer (Response → Domain)
        ↓
    GameDomainModel[] 
        ↓
    Realm Storage (Save)
        ↓
    @Published var games (Presenter)
        ↓
    SwiftUI View Re-renders
```

## 📦 Module Details

### Core Module
Foundation for all features with shared abstractions:
- **Protocols**: `UseCase`, `Repository`, `Interactor`
- **Base Classes**: `GetListPresenter` (generic list presenter)
- **Utilities**: Extension and networking utilities
- **Database**: Realm integration for local storage

### Games Module
Main game discovery and detail features:
- **Domain**: `GameDomainModel`, `DetailGameDomainModel`
- **Data**: Remote API, Local Realm storage, Repository
- **Presenter**: `GamePresenter` with @Published properties
- **Use Case**: `GameInteractor` for business logic

### Genres Module
Genre browsing and filtering:
- Genre list with grid display
- Genre-specific game filtering
- `GenreInteractor` for business logic

### Developers Module
Developer discovery and profiles:
- Developer list browsing
- Developer-specific game details
- `DeveloperInteractor` for queries

### Favorite Module
Favorites management with Realm persistence:
- Add/remove from favorites
- Persistent local storage
- Favorite status indicator across app
- `GetFavoritiesRepository` for CRUD operations

### SearchGame Module
Game search functionality:
- Real-time search by title
- Keyword-based filtering
- Search results display
- `GetSearchRepository` for queries

## 🎨 UI Components

### Reusable Components
- `GameItem` - Game card with image, rating, and title
- `GameFavoriteItem` - Favorite game list item
- `GenreItem` - Genre card for grid display
- `DeveloperItem` - Developer profile item
- `PlatformItem` - Platform compatibility display
- `Loading` - Loading state indicator
- `LottieView` - Lottie animation support
- `TitleSubtitle` - Section header component

### Navigation Structure
- **SplashView** (3-second intro animation)
- **HomeView** (Main tab navigation)
  - **HomeTab** - Discovery & featured content
  - **SearchTab** - Game search
  - **FavoriteTab** - Saved favorites
  - **ProfileTab** - User profile

## 🔄 Data Persistence

**Local Database**: Realm

### Storage Entities
- `GameModuleEntity` - Game data cache
- `GenreModuleEntity` - Genre data cache
- `DeveloperModuleEntity` - Developer data cache
- `SearchModuleEntity` - Search history

### Hybrid Caching Strategy
1. Fetch from local Realm (fast, offline-capable)
2. Update from remote API in background
3. Persist new data to local database
4. Reactive updates via Combine publishers

## 🧪 Testing

Each feature module includes comprehensive test targets:
- `CoreTests` - Core abstractions and utilities
- `GamesTests` - Game feature logic
- `GenresTests` - Genre feature logic
- `SearchGameTests` - Search functionality
- `FavoriteTests` - Favorites management

## 🔗 API Integration

**API Provider**: [RAWG.io Video Games Database](https://rawg.io/api)

### Base Endpoints
| Endpoint | Purpose |
|----------|---------|
| `/games` | Fetch games, apply filters & sorting |
| `/genres` | Get all available game genres |
| `/developers` | Fetch game developers |

### Response Models
- `GameResponse` / `DetailGameResponse` - Game data
- `GenreResponse` / `DetailGenreResponse` - Genre data
- `DeveloperResponse` - Developer profiles
- `SearchResponse` - Search results

## 🔧 Building & Deployment

### Local Build
```bash
xcodebuild build \
  -project Gamepedia.xcodeproj \
  -scheme Gamepedia \
  CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO
```

### CI/CD Pipeline (CodeMagic)
- **Workflow**: `ios-project-debug`
- **Environment**: Latest Xcode, CocoaPods
- **Scripts**: Build app, Build for testing
- **Artifacts**: Compiled `.app` files
- **Publishing**: Email notifications to `ridhoafni.dev@gmail.com`

View build status: [![Codemagic build status](https://api.codemagic.io/apps/69cf9432c67af7fcb8ff114c/ios-project-debug/status_badge.svg)](https://codemagic.io/app/69cf9432c67af7fcb8ff114c/ios-project-debug/latest_build)

## 📝 Project Highlights

✅ **Modern Architecture** - Clean, testable, and maintainable code structure  
✅ **Reactive by Default** - Combine framework for seamless asynchronous operations  
✅ **Modular Design** - SPM-based modules for code reusability and isolation  
✅ **Type Safety** - Leverages Swift's strong type system throughout  
✅ **Scalable Patterns** - Generic presenters and protocols for easy feature additions  
✅ **Offline Support** - Local caching with Realm for enhanced UX  
✅ **Professional CI/CD** - CodeMagic integration for automated builds & testing  
✅ **Comprehensive Error Handling** - Type-safe error propagation and management  

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Ridho Afni**
- Email: ridhoafni.dev@gmail.com
- GitHub: [@ridhoafni-dev](https://github.com/ridhoafni-dev)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Support

For issues, questions, or suggestions, please open an issue on the GitHub repository.

---

**Built with ❤️ using SwiftUI & Clean Architecture**
