defmodule ChatroomWithPhoenix.RoomChannel do
  use Phoenix.Channel
  
  def join("rooms:" <> room_id, _message, socket) do  
    if Enum.any?(Agent.get(Rooms, fn list -> list end), fn(room) -> room == room_id end) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end
  def handle_in("new_msg", %{"body" => body}, socket) do
    push socket, "new_msg", %{body: "Enter"}
    broadcast! socket, "new_msg", %{body: body}
    {:reply, :ok, socket}
  end
  def handle_info(:after_join, socket) do
    broadcast_from! socket, "new_msg", %{body: "Login"}
    {:noreply, socket}
  end
end