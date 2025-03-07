# 📝 ToDo App - BLoC & Cubit Playground

## 📌 Project Overview

The **ToDo App** is an **educational Flutter application** that demonstrates advanced **state management techniques** using both **BLoC** and **Cubit** patterns. The app serves as a **learning resource** for exploring different **state management approaches** and **side effect handling** through **BLoC Listener** and **Stream Subscriptions**.

---

## 🎯 Key Objectives

- **State Management Versatility:** Switch between **BLoC** and **Cubit** seamlessly.
- **Showcase of State Shapes:** Demonstrate **BLoC Listener**, **Stream Subscription**, and **UI separation** techniques.
- **Educational Playground:** Document and compare **BLoC** and **Cubit** state management for future reference.

---

## 🏗️ Project Structure

### 🌐 Core

- **Config:** (`core/config/`)

  - **AppConfig, AppConstants, AppStrings, AppTheme, AppStyles, AppBlocObserver**.

- **Models:** (`core/models/`)

  - Contains data models shared across the app.

- **Utils:** (`core/utils/`)
  - **Helpers, Debounce, ShowDialog, Block & Cubit Exporters**.

### 🧩 Features

- **Header:** Displays the ToDo list header and active ToDo count.
- **Filter:** Manages ToDo filters (`All`, `Active`, `Completed`).
- **Search:** Enables dynamic searching of ToDos.
- **ToDo List:** Manages CRUD operations for ToDos.
- **Filtered ToDo List:** Reacts to filters and search queries dynamically.

### 🎨 Presentation

- **Pages:** (`presentation/pages/`)
  - **TodosPage:** Main page of the app, composed of smaller widget components.
  - **Widgets:** Custom reusable UI components.

---

## 🚀 Features & Highlights

- **Dynamic State Switching:** Toggle between **BLoC** and **Cubit** for state management.
- **Support for Side Effects:** Implemented with both **BLoC Listener** and **Stream Subscription** approaches.
- **Flexible UI Binding:** UI can react to state changes with minimal rebuilds using **context.select**.
- **Single Responsibility Principle:** All business logic is handled outside of the UI layer.

---

## 📌 Tech Stack

- **Flutter** (Material Design 3)
- **Dart**
- **flutter_bloc** (BLoC & Cubit)
- **Factory Pattern** for state management
- **Clean Architecture & SOLID Principles**

---

## 🛠️ Getting Started

1. Clone the repository:

```bash
git clone https://github.com/RamanGodun/TODO-APP-CUBIT-BLOC-.git
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

---

## 📖 Learning Outcomes

- ✅ Understand advanced **BLoC & Cubit** state management techniques.
- ✅ Learn to handle **side effects** effectively using **BLoC Listener** and **Stream Subscriptions**.
- ✅ Explore **state management switching** and **dynamic state shapes**.
- ✅ Maintain **clean architecture** and follow **best coding practices**.

---

## 🔍 License

This project is licensed under the [MIT License](LICENSE).


/*

     ! NEED TO DO next:

? 1. Data persistence (SQLie or Hive)
? 2. Additional state management ("In Progress" state with CircularProgressIndicator)
? 3. Error dialog
? 4. Pagination (traditional or infinite scrolling)
? 5. Use TextWidget, not Text(...)
? 6. Use custom showDialog
? 7. Refactor design
? 8. Use onGenerate routes navigation if add extra pages

 */
