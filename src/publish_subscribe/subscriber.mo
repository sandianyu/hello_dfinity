import Nat "mo:base/Nat";
import Publisher "./publisher";

actor Subscriber {
  var count: Nat = 0;

  public func init() {
    let publisher: Publisher.Publisher = await Publisher.Publisher();
    publisher.subscribe({ notify = incr; });
  };
  
  public func incr() {
    count += 1;
  };

  public query func get(): async Nat {
    count
  };
};