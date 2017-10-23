defmodule MicroblogWeb.UpdatesChannelTest do
  use MicroblogWeb.ChannelCase

  alias MicroblogWeb.UpdatesChannel

  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(UpdatesChannel, "updates:lobby")

    {:ok, socket: socket}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
