import Cycles "mo:base/ExperimentalCycles";
import Debug "mo:base/Debug";
import Bank "./main";

actor Test {
  public func test() : async () {
    Cycles.add(1_000_000_000_000);
    let bank = await Bank.Bank(Test.credit, 1_000_000_000);

    assert(0 == (await bank.getSavings()));

    Cycles.add(1_000_000);

    await bank.deposit();
    Debug.print("after deposit 1" # debug_show((await bank.getSavings())));

    await bank.withdraw(500_000);
    Debug.print("after withdraw 1" # debug_show((await bank.getSavings())));

    await bank.withdraw(500_000);
    Debug.print("after withdraw 2" # debug_show((await bank.getSavings())));

    Cycles.add(2_000_000_000);
    await bank.deposit();
    Debug.print("after deposit 2" # debug_show((await bank.getSavings())));
    
    let refund = Cycles.refunded();
    Debug.print("refund" # debug_show(refund));
    Debug.print("after refund" # debug_show((await bank.getSavings())));
  };

  public func credit(): async () {
    let available = Cycles.available();
    let accepted = Cycles.accept(available);
    assert(accepted == available);
  };
};
