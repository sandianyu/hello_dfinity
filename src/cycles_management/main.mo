import Cycles "mo:base/ExperimentalCycles";
import Debug "mo:base/Debug";
import Principal "mo:base/Principal";

shared(msg) actor class Bank(
  benifit: shared () -> async(),
  capacity: Nat
) {
  let owner = msg.caller;

  Debug.print(Principal.toText(owner));

  var savings = 0;

  public shared(msg) func getSavings(): async Nat {
    // assert(msg.caller == owner);
    Debug.print(Principal.toText(msg.caller));
    return savings;
  };

  public func deposit(): async() {
    let amount = Cycles.available();
    let limit: Nat = capacity - savings;
    let acceptable = 
      if (amount <= limit) amount
      else limit;
    let accepted = Cycles.accept(acceptable);
    assert(accepted == acceptable);
    savings += acceptable
  };

  public shared(msg) func withdraw(amount: Nat): async() {
    // assert(msg.caller == owner);
    assert(amount <= savings);
    Cycles.add(amount);
    await benifit();
    let refund = Cycles.refunded();
    savings -= amount - refund;
  };
};
