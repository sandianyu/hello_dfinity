import Principal "mo:base/Principal";
import Cycles "mo:base/ExperimentalCycles";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

actor {
  let ic00 = actor "aaaaa-aa": actor {
    deposit_cycles: shared { canister_id: Principal } -> async ();
  };

  public shared(msg) func deposit(canisterId: Text): async Nat{
    Debug.print("===>cycles before deposit: " # Nat.toText(Cycles.balance()));
    let principal = Principal.fromText(canisterId);
    Cycles.add(1_000_000_000);
    await ic00.deposit_cycles({ canister_id = principal });
    Debug.print("===>cycles after deposit: " # Nat.toText(Cycles.balance()));
    return Cycles.balance();
  };
};
