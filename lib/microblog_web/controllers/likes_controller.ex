defmodule MicroblogWeb.LikesController do
  use MicroblogWeb, :controller

  alias Microblog.Social
  alias Microblog.Social.Likes

  action_fallback MicroblogWeb.FallbackController

  def index(conn, %{"message_id" => message_id}) do
    likes = Social.get_likes_by_message_id(message_id)
    render(conn, "index.json", likes: likes)
  end

  def index(conn, _params) do
    likes = Social.list_likes()
    render(conn, "index.json", likes: likes)
  end

  def create(conn, %{"likes" => likes_params}) do
    with {:ok, %Likes{} = likes} <- Social.create_likes(likes_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", likes_path(conn, :show, likes))
      |> render("show.json", likes: likes)
    end
  end

  def show(conn, %{"id" => id}) do
    likes = Social.get_likes!(id)
    render(conn, "show.json", likes: likes)
  end

  def update(conn, %{"id" => id, "likes" => likes_params}) do
    likes = Social.get_likes!(id)

    with {:ok, %Likes{} = likes} <- Social.update_likes(likes, likes_params) do
      render(conn, "show.json", likes: likes)
    end
  end

  def delete(conn, %{"id" => id}) do
    likes = Social.get_likes!(id)
    with {:ok, %Likes{}} <- Social.delete_likes(likes) do
      send_resp(conn, :no_content, "")
    end
  end
end
