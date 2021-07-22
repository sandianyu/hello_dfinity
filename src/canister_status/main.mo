import Principal "mo:base/Principal";
import Debug "mo:base/Debug";

actor Self {
  let IC = 
    actor "aaaaa-aa": actor {
      canister_status: { canister_id: Principal } ->
        async {
          settings: { controllers: [Principal] }
        };
  };

  public func get_controllers(): async [Principal] {
    let principal = Principal.fromActor(Self);
    let status = await IC.canister_status({ canister_id = principal });
    return status.settings.controllers;
  };
};
