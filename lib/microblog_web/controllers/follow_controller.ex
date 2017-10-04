defmodule MicroblogWeb.FollowController do
  use MicroblogWeb, :controller

  alias Microblog.Social
  alias Microblog.Accounts
  alias Microblog.Social.Follow

  def index(conn, _params) do
    current_user_id = get_session(conn, :user_id)
    follows = Social.list_follows_by_follower_id(current_user_id)
    followed_ids = Enum.map(follows, fn(follow) -> follow.followee_id end)
    users = Accounts.list_users()
    unfollowed_users = Enum.filter(users, fn(user) -> !(Enum.member?(followed_ids, user.id) || user.id == current_user_id) end)
    render(conn, "index.html", follows: follows, users: unfollowed_users)
  end

  def new(conn, _params) do
    changeset = Social.change_follow(%Follow{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"followee_id" => followee_id, "follower_id" => follower_id}) do
    case Social.create_follow(%{"follower_id" => follower_id, "followee_id" => followee_id}) do
      {:ok, follow} ->
        conn
        |> put_flash(:info, "Follow created successfully.")
        |> redirect(to: follow_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    follow = Social.get_follow!(id)
    render(conn, "show.html", follow: follow)
  end

  def edit(conn, %{"id" => id}) do
    follow = Social.get_follow!(id)
    changeset = Social.change_follow(follow)
    render(conn, "edit.html", follow: follow, changeset: changeset)
  end

  def update(conn, %{"id" => id, "follow" => follow_params}) do
    follow = Social.get_follow!(id)

    case Social.update_follow(follow, follow_params) do
      {:ok, follow} ->
        conn
        |> put_flash(:info, "Follow updated successfully.")
        |> redirect(to: follow_path(conn, :show, follow))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", follow: follow, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    follow = Social.get_follow!(id)
    {:ok, _follow} = Social.delete_follow(follow)

    conn
    |> put_flash(:info, "Follow deleted successfully.")
    |> redirect(to: follow_path(conn, :index))
  end
end
