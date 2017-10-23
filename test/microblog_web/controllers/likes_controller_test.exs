defmodule MicroblogWeb.LikesControllerTest do
  use MicroblogWeb.ConnCase

  alias Microblog.Social
  alias Microblog.Social.Likes

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:likes) do
    {:ok, likes} = Social.create_likes(@create_attrs)
    likes
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
  end

  describe "create likes" do
  end

  describe "update likes" do
    setup [:create_likes]
  end

  describe "delete likes" do
    setup [:create_likes]
  end

  defp create_likes(_) do
    likes = fixture(:likes)
    {:ok, likes: likes}
  end
end
