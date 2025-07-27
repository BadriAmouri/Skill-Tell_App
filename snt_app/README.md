# this is the app folder structure 

lib/
│
├── constants/              # API endpoints and other constant values
│   └── endpoints.dart
│
├── theme/                  # App-wide theme settings (colors, fonts)
│   ├── app_colors.dart
│   ├── app_text_styles.dart
│   └── theme.dart
│
├── utils/                  # Utility widgets used across the app
│   ├── custom_button.dart
│   ├── custom_input.dart
│   └── icon_widget.dart
│
├── screens/                # All screen files (organized by feature/page)
│   ├── home/
│   │   └── home_screen.dart
│   └── login/
│       └── login_screen.dart
│
├── widgets/                # Shared, reusable widgets (non-global)
│   ├── header.dart
│   └── footer.dart
│
├── assets/                 # Images, icons, etc. (use in pubspec.yaml)
│   ├── images/
│   └── icons/
│
└── main.dart               # Entry point of the application



#  Flutter App Folder Structure

This document describes the clean and scalable folder structure for this Flutter application.

---

##  lib/

The main source code of the app lives here.

---

###  constants/

- Stores all static constants used throughout the app, such as API endpoints, route names, etc.
-  `endpoints.dart` — API endpoint URLs.

---

###  theme/

- App-wide theming definitions.
-  `app_colors.dart` — Color definitions in one place.
-  `app_text_styles.dart` — Font sizes, weights, and text styles.
-  `theme.dart` — Combines all theming settings into one ThemeData object.

---

###  utils/

- Globally reusable UI widgets like buttons, inputs, and icon widgets.
- Meant to be imported in multiple screens.

---

###  screens/

- Contains all the different screens of the app, organized by feature/module.
- Each screen has its own subfolder.

Example:
```plaintext
screens/
  └── login/
      └── login_screen.dart
