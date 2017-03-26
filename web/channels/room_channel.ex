defmodule ChatroomWithPhoenix.RoomChannel do
  use Phoenix.Channel
  def join("room:lobby", message, socket) do
    send(self(), {:after_join, message["user"]})
    {:ok, "lobby", socket}
  end
  def join("room:" <> room_id, message, socket) do  
    if Enum.any?(Agent.get(Rooms, fn list -> list end), fn(room) -> room == room_id end) do
      send(self(), {:after_join, message["user"]})
      {:ok, room_id, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end
  def handle_in("new_msg", msg, socket) do
    #push socket, "new_msg", %{body: "Enter"}
    broadcast! socket, "new_msg", %{user: socket.assigns[:username], body: msg["body"]}
    {:reply, :ok, socket}
  end
  def handle_info({:after_join, user}, socket) do
    socket = assign(socket, :username, user)
    push socket, "new_msg", %{user: "SYSTEM", body: "Hello #{user}"}
    broadcast_from! socket, "new_msg", %{user: "SYSTEM", body: "#{user} Login"}
    {:noreply, socket}
  end
  def terminate(reason, socket) do
    case reason do
      {:shutdown, :closed} -> IO.puts "Shutdown"
      _ -> IO.puts "Any"
    end
    broadcast_from! socket, "new_msg", %{user: "SYSTEM", body: "#{socket.assigns[:username]} Logout"}
    :ok
  end
end