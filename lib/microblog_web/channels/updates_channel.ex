defmodule MicroblogWeb.UpdatesChannel do
  use MicroblogWeb, :channel
  alias Phoenix.Socket

  def join("updates:" <> user_id, payload, socket) do
    if authorized?(payload) do
      Socket.assign(socket, :user_id, user_id)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("new_message", payload, socket) do
    # socket: "updates:id"
    # find all followers of Messages(id)
    # for all followers, broadcast new message to updates:follower_id
    {:reply, {:ok, payload}, socket}
  end


  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
