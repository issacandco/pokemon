# Pokémon Flutter App

An assessment project from Jarvix.

## Getting Started

This project is a Flutter application using the following versions:

- **Flutter version**: 3.24.3
- **Dart version**: 3.5.3

### Prerequisites

Before starting, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   ```
2. **Navigate to the project directory:**
   ```bash
   cd pokemon
   ```
3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

### Running the Application

This project uses different flavors for development, staging, and production environments. You can run the app using one of the following commands:

- **Development**:
  ```bash
  flutter run --flavor development -t lib/main_development.dart
  ```

- **Staging**:
  ```bash
  flutter run --flavor staging -t lib/main_staging.dart
  ```

- **Production**:
  ```bash
  flutter run --flavor production -t lib/main_production.dart
  ```

## Features

1. **Pokédex Integration**: Uses the [PokéAPI](https://pokeapi.co/) to retrieve Pokémon data.
2. **Search Page**: Allows users to search for Pokémon based on name or ID.
3. **Pokédex Page**: Displays a list of Pokémon with pagination and infinite scroll, along with filter options.
4. **Backpack Page**: Users can view and manage their owned Pokémon, with a sorting feature to organize the list.
5. **Favourites Page**: Displays a list of Pokémon marked as favourites.
6. **Wild Pokémon Encounter**: Users can randomly encounter a wild Pokémon and choose to catch or run from them.
7. **Internet Connectivity Check**: Prevents access to features that require an active internet connection.

## Folder Structure

```
├── lib
│   ├── main_development.dart       # Entry point for development
│   ├── main_staging.dart           # Entry point for staging
│   ├── main_production.dart        # Entry point for production
│   ├── models/                     # Data models
│   ├── controllers/                # General Business logic controllers
│   ├── pages/                      # UI pages and widgets with their respective view models
│   ├── services/                   # API and network services
│   └── utils/                      # Basic utilites
```

## Additional Information

- **PokéAPI Documentation**: [https://pokeapi.co/docs/v2](https://pokeapi.co/docs/v2)
- **Report Issues**: If you encounter any issues, feel free to create an issue in the repository.
