actor {
  public func test(num: Nat): async Nat {
    if (10 > num - 1) {
      return num;
    };
    return num + 1;
  };
};
