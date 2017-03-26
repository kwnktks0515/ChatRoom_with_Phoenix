defmodule ChatroomWithPhoenix.Worker do
    def start_link do
        Agent.start_link(fn -> ["room1", "room2"] end, name: Rooms)
    end
end