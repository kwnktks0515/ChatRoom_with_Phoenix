defmodule ChatroomWithPhoenix.PageController do
  use ChatroomWithPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
