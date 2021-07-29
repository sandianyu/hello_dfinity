import Nat64 "mo:base/Nat64";
import Cycles "mo:base/ExperimentalCycles";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";

// shared(msg) actor class HelloCylces (
//   capacity: Nat
// ) {
//   var balance = 0;

//   public shared(msg) func wallet_balance(): async Nat {
//     balance
//   };

//   public func wallet_receivce(): async { accepted: Nat64 } {
//     let amount = Cycles.available();
//     let limit: Nat = capacity - balance;
//     let accepted = 
//       if (amount <= limit) amount
//       else limit;
//     let deposit = Cycles.accept(accepted);
//     assert (deposit == accepted);
//     balance += accepted;
//     { accepted = Nat64.fromNat(accepted) };
//   };

//   public shared(msg) func owner(): async Principal {
//     let currentOwner = msg.caller;
//     return currentOwner;
//   };
// };
actor {
  public shared(msg) func wallet_balance(): async Nat {
    Debug.print("canister hello_cylces: " # Nat.toText(Cycles.balance()));
    return Cycles.balance();
  };
};
