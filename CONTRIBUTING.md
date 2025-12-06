# Contributing to [Flyer Chat](https://flyer.chat) 💬

First off, thank you for considering contributing to Flyer Chat! 🎉 We welcome any contributions that help make this project better, from reporting bugs and suggesting features to submitting code changes.

This document provides guidelines for contributing to the project.

## Code of Conduct

We expect all contributors to adhere to our [Code of Conduct](https://github.com/flyerhq/flutter_chat_ui/blob/main/CODE_OF_CONDUCT.md). Please read it to understand the standards we strive for.

## Ways to Contribute

There are many ways to contribute:

- **Reporting Bugs:** If you find a bug, please report it by opening an issue.
- **Suggesting Enhancements:** Have an idea for a new feature or an improvement? Open a discussion to share your thoughts with the community.
- **Improving Documentation:** Spot a typo or think something could be clearer? Let us know by opening an issue.
- **Writing Code:** Help fix bugs or implement new features.
- **Creating Examples/Packages:** Follow the steps below to add new examples or packages.

## Reporting Bugs & Suggesting Enhancements

Before creating a new issue:

1.  **Search existing issues and/or discussions:** Check if the bug or feature request has already been reported or suggested.
2.  **Provide details:** If creating a new issue, please include as much detail as possible. For bugs, include steps to reproduce, expected behavior, actual behavior, Flutter version, and package versions. For enhancements, explain the motivation and proposed solution.

## Development Setup & Workflow

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Melos](https://melos.invertase.dev/): Install via `dart pub global activate melos`

### Initial Setup

1.  Fork the repository on GitHub.
2.  Clone your fork locally: `git clone https://github.com/YOUR_USERNAME/flutter_chat_ui.git`
3.  Navigate to the project directory: `cd flutter_chat_ui`
4.  Bootstrap the project using Melos (installs dependencies for all packages): `melos bootstrap` or `melos bs`

### Creating a New Example

1.  Navigate to the examples directory:
    ```bash
    cd examples
    ```
2.  Create the Flutter project:
    ```bash
    flutter create example_name --org chat.flyer
    ```
3.  Return to the root directory:
    ```bash
    cd ..
    ```
4.  Add the example to the root `pubspec.yaml` under the `workspace` key:
    ```yaml
    workspace:
      - examples/example_name
      # ... other packages
    ```
5.  Add `resolution: workspace` to the example's `pubspec.yaml` after the `environment` section:

    ```yaml
    environment:
      sdk: ^3.7.0

    resolution: workspace
    ```

6.  Bootstrap Melos to link packages:
    ```bash
    melos bs
    ```
7.  Replace the content of `examples/example_name/analysis_options.yaml` with:
    ```yaml
    include: ../../analysis_options.yaml
    ```

### Creating a New Package

1.  Navigate to the packages directory:
    ```bash
    cd packages
    ```
2.  Create the Flutter package:
    ```bash
    flutter create --template=package package_name
    ```
3.  Return to the root directory:
    ```bash
    cd ..
    ```
4.  Add the package to the root `pubspec.yaml` under the `workspace` key:
    ```yaml
    workspace:
      - packages/package_name
      # ... other packages
    ```
5.  Add `resolution: workspace` to the package's `pubspec.yaml` after the `environment` section:

    ```yaml
    environment:
      sdk: ">=3.7.0 <4.0.0"

    resolution: workspace
    ```

6.  Bootstrap Melos:
    ```bash
    melos bs
    ```
7.  Replace the content of `packages/package_name/analysis_options.yaml` with:
    ```yaml
    include: ../../analysis_options.yaml
    ```
8.  Structure the package similarly to existing ones. Essential files include:
    ```
    lib/
      src/
        # Your Dart code
      package_name.dart # Exports
    analysis_options.yaml
    CHANGELOG.md
    LICENSE
    pubspec.yaml
    README.md
    ```
    Remove unnecessary generated files and update `pubspec.yaml`.
9.  Run `melos bs` again after modifying `pubspec.yaml`.

### Common Melos Commands

- **Get/Link Dependencies:** `melos bootstrap` or `melos bs`
- **Clean:** `melos clean` (removes build artifacts, pub caches, etc.)
- **Run All Tests:** `melos test`
- **Run Tests Selectively:** `melos run test:selective` (prompts for package selection)
- **Generate Coverage:** `melos coverage`
- **Generate Coverage Selectively:** `melos run coverage:selective`
- **Analyze Code:** `melos analyze`
- **Format Code:** `melos format`
- **Apply Fixes:** `melos run fix`
- **(flutter_chat_core) Build Runner:** `melos run build`

## Code Style

Please adhere to the code style defined in the root `analysis_options.yaml` file.

- Run `melos format` to format your code before committing.
- Run `melos analyze` to check for static analysis issues.

## Pull Request Process

1.  Ensure you have followed the [Development Setup](#development-setup--workflow).
2.  Create a new branch for your changes based on the `main` branch:
    ```bash
    git checkout main
    git pull origin main # Ensure you have the latest changes
    git checkout -b your-branch-name # e.g., fix/message-bug or feat/new-message-type
    ```
3.  Make your code changes.
4.  Add relevant tests for your changes.
5.  Run tests: `melos test`
6.  Format code and check analysis: `melos format && melos analyze`
7.  Commit your changes with a clear and concise commit message.
8.  Push your branch to your fork:
    ```bash
    git push origin your-branch-name
    ```
9.  Open a Pull Request (PR) from your fork's branch to the `flyerhq/flutter_chat_ui` `main` branch.
10. Provide a clear description of your PR, explaining the changes and linking to any relevant issues (e.g., `Fixes #123`).
11. Respond to any feedback or requested changes from the maintainers.

## License

By contributing, you agree that your contributions will be licensed under the [Apache License 2.0](LICENSE) that covers the project.
