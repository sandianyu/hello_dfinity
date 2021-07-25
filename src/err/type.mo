import Int "mo:base/Int";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Time "mo:base/Time";
import Text "mo:base/Text";

module {
  public type Time = Int;
  public type Seconds = Int;
  public type TodoId = Nat;
  public type Todo = { #todo: { text: Text; opened: Time }; #done: Time; };
  public type TodoMap = HashMap.HashMap<TodoId, Todo>;
  public type TodoError = { #notFound; #alreadyDone: Time };
};
