# 🐶 Dogs Feature

The **Dogs** feature module of the **Chief & Co.** app, structured using **Clean Architecture** principles with three layers: **Data**, **Domain**, and **Presentation**.

|  Home/Dogs  |  
|---|
| <img src="https://github.com/user-attachments/assets/cb5477e5-22bc-45be-8012-bad42810c78f" width="260"> |

---

## 🧠 Component Overview

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

This README summarizes the entire feature module and serves as a guide for contribution, testing, or further refactoring. Feel free to extend it with setup instructions or testing guides.



