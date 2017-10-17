defmodule MicroblogWeb.MessageController do
  use MicroblogWeb, :controller

  alias Microblog.Social
  alias Microblog.Accounts
  alias Microblog.Social.Message

  def index(conn, _params) do
    # messages = Social.list_messages()
    messages = Social.list_messages_by_user_id(get_session(conn, :user_id))
    render(conn, "index.html", messages: messages)
  end

  def new(conn, _params) do
    changeset = Social.change_message(%Message{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"message" => message_params}) do
    case Social.create_message(message_params) do
      {:ok, message} ->
        user = Accounts.get_user!(get_session(conn, :user_id))
        followers = Microblog.Social.list_follows_by_followee_id(user.id)
        IO.inspect(followers)
        Enum.each(followers, fn(f) -> IO.puts("trying")
        MicroblogWeb.Endpoint.broadcast("updates:"<> Integer.to_string(f.follower_id), "update",
                                                                       %{"message" => message.message,
                                                                       "username" => user.username,
                                                                       "message_id" => message.id,
                                                                       "user_id" => user.id}) end)
        conn
        |> put_flash(:info, "Message created successfully.")
        |> redirect(to: message_path(conn, :show, message))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Social.get_message!(id)
    render(conn, "show.html", message: message)
  end

  def edit(conn, %{"id" => id}) do
    message = Social.get_message!(id)
    changeset = Social.change_message(message)
    render(conn, "edit.html", message: message, changeset: changeset)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Social.get_message!(id)

    case Social.update_message(message, message_params) do
      {:ok, message} ->
        conn
        |> put_flash(:info, "Message updated successfully.")
        |> redirect(to: message_path(conn, :show, message))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", message: message, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Social.get_message!(id)
    {:ok, _message} = Social.delete_message(message)

    conn
    |> put_flash(:info, "Message deleted successfully.")
    |> redirect(to: message_path(conn, :index))
  end
end
