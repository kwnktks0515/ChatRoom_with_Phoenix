defmodule ChatroomWithPhoenix.Worker do
    def start_link do
        Agent.start_link(fn -> ["lobby"] end, name: Rooms)
    end
end