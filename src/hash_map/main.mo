import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Nat "mo:base/Nat";

actor {
  private var balances = HashMap.HashMap<Text, Nat>(0, Text.equal, Text.hash);
  private var count: Nat = 0;

  public func set(k: Text, v: Nat): async Bool {
    Debug.print("start time:" # debug_show(Time.now()));
    balances.put(k, v);
    Debug.print("end time:" # debug_show(Time.now()));
    return true;
  };

  public func add(a: Nat): async Nat {
    count += a;
    return count;
  };

  public func get(k: Text): async Nat {
    var balance: Nat = 0;

    switch(balances.get(k)) {
      case (?_balance) {
        balance := _balance;
      };
      case (_) {
        balance := 0;
      };
    };

    balance
  };
};