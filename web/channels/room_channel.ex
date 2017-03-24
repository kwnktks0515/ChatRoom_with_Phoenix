defmodule ChatroomWithPhoenix.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", _message, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end
  def join("rooms:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
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