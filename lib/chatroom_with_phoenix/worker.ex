defmodule ChatroomWithPhoenix.Worker do
    def start_link do
        Agent.start_link(fn -> [] end, name: Rooms)
    end
end