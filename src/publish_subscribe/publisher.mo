import Array "mo:base/Array";
import Types "./types";

shared actor class Publisher() {
  type Subscriber = Types.Subscriber;

  var subs: [Subscriber] = [];

  public func subscribe(sub: Subscriber) {
    subs := Array.append<Subscriber>(subs, [sub]);
  };

  public func publish() {
    for (sub in subs.vals()) {
      sub.notify();
    };
  };
};
