# 🐶 Dogs Feature

The **Dogs** feature of the **Chief & Co.** app, structured using **Clean Architecture** principles with three layers: **Data**, **Domain**, and **Presentation**.

|  Home/Dogs  |  
|---|
| <img src="https://github.com/user-attachments/assets/cb5477e5-22bc-45be-8012-bad42810c78f" width="260"> |

---

## 🧠 Component Overview

### 🧩 Core Layer

This folder contains shared foundational components and services that are reused across the entire app. These utilities support infrastructure-level concerns such as **networking**, **Core Data**, **dependency injection**, and **shared extensions**.

---

## 🚀 Module Overview

### 🔹 API (Networking)
- **APIClientProtocol.swift**  
  Defines the generic networking interface (e.g., `get<T>()`) used across data sources.

- **APIClient.swift**  
  Concrete implementation of `APIClientProtocol` using `URLSession`. Supports decoding and URL building.

- **HttpRequestHandler.swift**  
  Helps construct and debug `URLRequest` objects. Modularizes headers and method logic.

- **APIConfig.swift**  
  Centralized location for API-related configuration: `baseUrl`, endpoint paths.

---

### 🔹 Core Data
- **PersistentContainer.swift**  
  Custom `NSPersistentContainer` subclass that exposes a reusable `backgroundContext` and helper methods like `save()` and `hasChanges()`.

- **CoreDataInjector.swift**  
  Provides convenient access to the `NSManagedObjectContext` for background operations.

- **NSManagedObjectContext+Extension.swift**  
  Adds Core Data convenience methods:
  - `createEntity`
  - `saveContext`
  - `fetchManagedObject`
  - `deleteAll`

---

### 🔹 Dependency Injection
- **ChiefInjector.swift**  
  Central enum for building dependencies (e.g., APIClient, Repositories, ViewModels). Composes and injects everything for `HomeView` or others.

---

### 🔹 Extensions
- **View+Extensions.swift**  
  Adds SwiftUI-specific modifiers and helpers. Can be expanded with common UI utilities (e.g., custom placeholders, corner styling).

---

### 🔹 Utilities
- **Constants.swift**  
  A centralized file for constants used across the app (e.g., image placeholders, spacing, strings).

---

### 🏗 Architectural Role

- **Reusable Core Services**: Abstracts common infra like networking and persistence.
- **Loose Coupling**: Promotes testability by injecting dependencies (e.g., APIClientProtocol).
- **Single Source of Truth**: API configs and persistent stores are defined once and reused.
- **Scalable Design**: Easily expandable with additional modules (e.g., LoggingService, Analytics).

---

### 🔄 Used By

- `Features/Dogs/`: Depends on `APIClient`, `CoreDataInjector`, and `ChiefInjector` from this layer.
- Future features will reuse Core Data helpers and DI setup from here.

---

### 🔹 Data Layer
- **DogApiModel.swift** – Maps the raw API JSON response.
- **DogsRemoteDataSource.swift** – Handles the remote API call (`GET /dogs`), returns `[DogApiModel]`.
- **DogsLocalDataSourceCoreData.swift** – Handles local persistence using Core Data.
- **DogsRepository.swift** – 
  - Attempts to fetch from the remote source first.
  - Saves remote data locally if successful.
  - Falls back to local Core Data if the remote call fails.

### 🔹 Domain Layer
- **Dog.swift** – Pure domain entity with properties like `name`, `description`, `age`, `imageUrl`.
- **DogsRepositoryProtocol.swift** – Interface defining `fetchDogs() async -> Result<[Dog], Error>`.
- **GetDogsUseCase.swift** – Application logic for retrieving dogs, delegates to repository.

### 🔹 Presentation Layer
- **DogsViewModel.swift** –
  - Exposes `@Published` properties: `[DogUI]`, `isLoading`, and `errorMessage`.
  - Calls the use case to load data and maps domain models to UI models.
- **DogUI.swift** – 
  - View-specific model conforming to `Identifiable`.
  - Prepares display-friendly values like formatted age.
- **HomeView.swift** – 
  - Main SwiftUI view showing a list of dogs.
  - Binds to `DogsViewModel`.
- **DogCardView.swift** – 
  - Visual representation for each dog item using `AsyncImage`, shadows, rounded UI.

---

## 🔁 Data Flow

1. `HomeView` is initialized via `ChiefInjector`, injecting the `DogsViewModel`.
2. On appearance, the ViewModel triggers `loadDogs()`.
3. `GetDogsUseCase` requests data from the repository.
4. `DogsRepository` tries to fetch from remote and stores data locally.
5. If remote fails, it retrieves data from Core Data.
6. `DogsViewModel` receives domain models and maps them to `DogUI`.
7. `HomeView` displays the list using `DogCardView`.

---

## ✅ Next Steps

- Add **unit tests** for:
  - `DogsLocalDataSourceCoreData` (using in-memory Core Data).
  - `DogsRepository` (with mocks for remote/local).
  - `DogsViewModel` (with mock use case).
- Implement navigation to a `DogDetailView`.
- Improve error handling.

---

## 🛠 Architecture Highlights

- Clean separation of concerns (Data / Domain / Presentation).
- Swappable implementations (e.g. local vs remote).
- Testability-first design using protocols and dependency injection.
- Uses `MainActor` and `@Published` for reactive UI updates.
- UI logic isolated from business and infrastructure code.

---



