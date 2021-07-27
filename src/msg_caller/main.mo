import Principal "mo:base/Principal";
import Debug "mo:base/Debug";

actor {
  public shared(msg) func get(): async Nat {
    let caller = Principal.toText(msg.caller);
    Debug.print(caller);
    1
  };
};
