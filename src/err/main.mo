import Int "mo:base/Int";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Time "mo:base/Time";
import Result "mo:base/Result";
import Error "mo:base/Error";
import Types "./type";

shared actor class Err() {
  type TodoId = Types.TodoId;
  type Todo = Types.Todo;
  type TodoMap = Types.TodoMap;
  type Time = Types.Time;
  type Seconds = Int;
  type TodoError = Types.TodoError;

  type Result<Ok, Err> = { #ok: Ok; #err: Err };

  func secondsBetween(start: Time, end: Time): Seconds = (end - start) / 1_000_000_000;

  var idGen: TodoId = 0;
  let todos: TodoMap = HashMap.HashMap(32, Int.equal, Hash.hash);

  private func nextId(): TodoId {
    let id = idGen;
    idGen += 1;
    id
  };

  public shared func newTodo(text: Text): async TodoId {
    let id = nextId();
    let now = Time.now();
    todos.put(id, #todo({ text = text; opened = now; }));
    id
  };

  public shared func markDoneBad(id: TodoId): async Seconds {
    switch (todos.get(id)) {
      case (?(#todo(todo))) {
        let now = Time.now();
        todos.put(id, #done(now));
        secondsBetween(todo.opened, now);
      };
      case (_) { -1 };
    };
  };

  public shared func todoDone1(id: TodoId): async Text {
    let seconds = await markDoneBad(id);
    if (seconds != -1) {
      "Congrats! That took " # Int.toText(seconds) # " seconds";
    } else {
      "Someting went wrong."
    };
  };

  public shared func markDoneOption(id: TodoId): async ?Seconds {
    switch (todos.get(id)) {
      case (?(#todo(todo))) {
        let now = Time.now();
        todos.put(id, #done(now));
        ?(secondsBetween(todo.opened, now))
      };
      case (_) { null };
    };
  };

  public shared func todoDone2(id: TodoId): async Text {
    switch (await markDoneOption(id)) {
      case (null) {
        "Something went wrong"
      };
      case (?seconds) {
        "Congrats! That took " # Int.toText(seconds) # " seconds";
      };
    };
  };

  public shared func markDoneResult(id: TodoId): async Result.Result<Seconds, TodoError> {
    switch (todos.get(id)) {
      case (?(#todo(todo))) {
        let now = Time.now();
        todos.put(id, #done(now));
        #ok(secondsBetween(todo.opened, now))
      };
      case (?(#done(time))) {
        #err(#alreadyDone(time));
      };
      case (null) {
        #err(#notFound)
      };
    };
  };

  public shared func doneTodo3(id: TodoId): async Text {
    switch (await (markDoneResult(id))) {
      case (#err(#notFound)) {
        "There is no Todo with that id";
      };
      case (#err(#alreadyDone(at))) {
        let doneAgo = secondsBetween(at, Time.now());
        "You've already completed this todo " # Int.toText(doneAgo) # " seconds ago."
      };
      case (#ok(seconds)) {
        "Congrats! That took " # Int.toText(seconds) # " seconds.";
      };
    };
  };

  public shared func markDoneException(id: TodoId): async Seconds {
    switch (todos.get(id)) {
      case (?(#todo(todo))) {
        let now = Time.now();
        todos.put(id, #done(now));
        secondsBetween(todo.opened, now);
      };
      case (?(#done(time))) {
        throw Error.reject("Already done")
      };
      case (null) {
        throw Error.reject("Not Found")
      };
    };
  };

  public shared func todoDone4(id: TodoId): async Text {
    try {
      let seconds = await markDoneException(id);
      "Congrats! That took " # Int.toText(seconds) # " seconds"
    } catch (e) {
      "Something went wrong"
    }
  };
};
