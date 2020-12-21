const String CODE_1 = "1", CODE_2 = "2", CODE_401 = "401";

void logD(Object o) {
  assert(() {
    print(o);
    return true;
  }());
}