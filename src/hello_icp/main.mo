import Array "mo:base/Array";
import Nat "mo:base/Nat";

actor Assistant {
    stable var todos: [Todo] = [];
    stable var nextId: Nat = 1;

    type Todo = {
        id: Nat;
        description: Text;
        completed: Bool;
    };

    func add(todos: [Todo], description: Text, id: Nat): [Todo] {
        let todo: Todo = {
            id = id;
            description = description;
            completed = false;
        };

        Array.append(todos, [todo]);
    };

    func show(todos: [Todo]): Text {
        var output: Text = "\n___TO-DOs____";

        for (todo: Todo in todos.vals()) {
            output #= "\n(" # Nat.toText(todo.id) # ") " # todo.description;
            if (todo.completed) { output #= " done!"; };
        };

        output
    };

    public func addTodo(description: Text): async () {
        todos := add(todos, description, nextId);
        nextId += 1;
    };

    public query func showTodos(): async Text {
        show(todos);
    };
};
