import Nat64 "mo:base/Nat64";
import Cycles "mo:base/ExperimentalCycles";

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
shared(msg) actor class HelloCylces () {
};
