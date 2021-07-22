import Principal "mo:base/Principal";
import Cycles "mo:base/ExperimentalCycles";

shared(msg) actor class TokenManagement() {
  let ic00 = actor "aaaaa-aa": actor {
    deposit_cycles: Principal -> async ();
  };

  public shared(msg) func deposit(canisterId: Text): async Nat{
    let principalId = Principal.fromText(canisterId);
    ignore ic00.deposit_cycles(principalId);
    return Cycles.balance();
  };
};
