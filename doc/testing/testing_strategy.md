# 🧪 Testing Strategy & Guidelines

This document outlines the testing strategy for the Jar application, built with **Clean Architecture, MVVM, and Riverpod**. 

Our primary focus is ensuring business logic is stable. We rely heavily on **Logic Integration Testing** to verify our architecture layers work together, and **Unit Testing** for isolated components.

---

## 1. Unit Testing (Isolated Logic)
Unit tests check isolated pieces of code (a single ViewModel, UseCase, or Repository). We mock immediate dependencies using `mocktail` to ensure tests run in milliseconds.

### Example: Testing a ViewModel (Riverpod)
To test a ViewModel, we use `ProviderContainer` to read the provider and a mocked `UseCase`.

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';

// 1. Create a Mock for the dependency
class MockAuthUseCase extends Mock implements AuthInitUseCase {}

void main() {
  late MockAuthUseCase mockUseCase;
  late ProviderContainer container;

  setUp(() {
    mockUseCase = MockAuthUseCase();
    container = ProviderContainer(
      overrides: [
        // Override the use case provider with our mock
        authInitUseCaseProvider.overrideWithValue(mockUseCase),
      ],
    );
  });

  test('AuthViewModel changes state to success on valid input', () async {
    // Arrange: Tell the mock to return success
    when(() => mockUseCase.execute(any()))
        .thenAnswer((_) async => Right(BasicResponse(success: true)));

    final viewModel = container.read(authViewModelProvider.notifier);

    // Act: Call the method
    await viewModel.initAuth("123456789");

    // Assert: Verify the state changed correctly
    final state = container.read(authViewModelProvider);
    expect(state.reqState, ReqState.success);
  });
}
```

---

## 2. Logic Integration Testing (Multi-Layer, No UI)
**This is exactly what you are asking for: testing the logic across multiple layers without rendering any Flutter UI.**

Instead of mocking the UseCase, we only mock the outermost boundary (e.g., the `Dio` HTTP client). We let the real **ViewModel** talk to the real **UseCase**, which talks to the real **Repository**.

**Why do this?** 
This guarantees that your entire data flow and architecture layers are communicating perfectly, without the slowness or flakiness of rendering UI screens.

### Example: Logic Integration Test (No UI)
```dart
void main() {
  late MockDioClient mockDio;
  late ProviderContainer container;

  setUp(() {
    mockDio = MockDioClient();
    
    // We initialize the DI container, but ONLY override the network layer!
    container = ProviderContainer(
      overrides: [
        // Only mock the lowest level network client!
        dioProvider.overrideWithValue(mockDio),
        
        // EVERYTHING ELSE (Repository, UseCase, ViewModel) IS REAL.
      ],
    );
  });

  test('Full Auth Flow Logic across all layers (No UI)', () async {
    // Arrange: Mock the backend response
    when(() => mockDio.post('/auth/init', data: any(named: 'data')))
        .thenAnswer((_) async => Response(
          statusCode: 200, 
          data: {"success": true, "message": "OTP Sent"},
          requestOptions: RequestOptions(),
        ));

    // Act: Trigger the ViewModel
    final viewModel = container.read(authViewModelProvider.notifier);
    await viewModel.initAuth("123456789");

    // Assert: Check the final state
    final state = container.read(authViewModelProvider);
    expect(state.reqState, ReqState.success);
  });
}
```

---

## 3. Test Folder Structure
To keep tests highly maintainable and easy to navigate, the `test/` folder should mirror the `lib/` folder structure exactly, separated by test types (`unit` and `integration`).

```text
test/
├── helpers/                      # Mock definitions, dummy data, and setup helpers
│   ├── mocks.dart                # Mock classes (MockDio, MockAuthUseCase)
│   ├── dummy_data.dart           # Pre-configured JSON/Model responses for easy reuse
│   └── test_extensions.dart      # Custom test matchers or ProviderContainer helpers
│
├── unit/                         # Isolated Unit Tests
│   ├── data/
│   │   ├── network/
│   │   │   └── error_handler_test.dart
│   │   └── repository/
│   │       └── repository_impl_test.dart
│   ├── domain/
│   │   └── usecase/
│   │       └── auth_init_usecase_test.dart
│   └── presentation/
│       └── viewmodels/
│           └── auth_viewmodel_test.dart
│
└── integration/                  # Logic Integration Tests (Multi-Layer, No UI)
    ├── auth/
    │   └── auth_flow_integration_test.dart
    └── products/
        └── fetch_products_integration_test.dart
```

**Key Rules for Folder Structure:**
1. **Strict Mirroring**: If a class is located at `lib/data/repository/repository_impl.dart`, its test MUST be located at `test/unit/data/repository/repository_impl_test.dart`.
2. **Centralized Helpers**: Never define mocks directly inside the test file if they will be reused across multiple files. Put them in `helpers/mocks.dart`.
3. **Naming Convention**: Every test file must end with `_test.dart` or Flutter won't run it.
