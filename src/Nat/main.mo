import Nat "mo:base/Nat";
import Nat64 "mo:base/Nat64";

actor {
  private var _nat: Nat = 0;
  private var _nat64: Nat64 = 0;

  public shared(msg) func setNat(num: Nat): async Nat {
    _nat := num;
    _nat
  };

  public shared(msg) func setNat64(num: Nat64): async Nat64 {
    _nat64 := num;
    _nat64
  };
};
