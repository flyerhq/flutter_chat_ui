## Create a new example or package

### To create a new example:

1. Go to examples folder

```bash
cd examples
```

2. Run the following command:

```bash
flutter create example_name --org flyer.chat
```

3. Go to the root folder

```bash
cd ..
```

4. Run melos bootstrap:

```bash
melos bs
```

5. Replace `analysis_options.yaml` content with the following:

```bash
include: ../../analysis_options.yaml

```

### To create a new package:

1. Go to packages folder

```bash
cd packages
```

2. Run the following command:

```bash
flutter create package_name --template=package
```

3. Go to the root folder

```bash
cd ..
```

4. Run melos bootstrap:

```bash
melos bs
```

5. Replace `analysis_options.yaml` content with the following:

```bash
include: ../../analysis_options.yaml

```

6. Make sure to follow other packages structure. Minimum required files are:

```
.dart_tool/
lib/
  src/
    code.dart
  package_name.dart
analysis_options.yaml
CHANGELOG.md
LICENSE
melos_package_name.iml
pubspec.lock
pubspec.yaml
README.md
```

Remove all other files if needed and update `pubspec.yaml` similar to other packages.

Remember to run `melos bs` again after you finished all configs and changed `pubspec.yaml` file.

## Tests

To run tests for a specific package:

```bash
melos test:selective
```

To run all tests:

```bash
melos test
```

To generate coverage for a specific package:

```bash
melos coverage:selective
```

To generate coverage for all packages:

```bash
melos coverage
```

## Misc

Get dependencies for all packages:

```bash
melos bs
```

Clean all packages:

```bash
melos clean
```

Build types (flutter_chat_types):

```bash
melos build
```

Additional:

```bash
melos analyze
melos format
melos fix
```
