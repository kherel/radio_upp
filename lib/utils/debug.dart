class Application {
  static bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  static bool get isInReleaseMode {
    return !isInDebugMode;
  }
}
