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
    test "lists all likes", %{conn: conn} do
      conn = get conn, likes_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create likes" do
    test "renders likes when data is valid", %{conn: conn} do
      conn = post conn, likes_path(conn, :create), likes: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, likes_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, likes_path(conn, :create), likes: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update likes" do
    setup [:create_likes]

    test "renders likes when data is valid", %{conn: conn, likes: %Likes{id: id} = likes} do
      conn = put conn, likes_path(conn, :update, likes), likes: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, likes_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, likes: likes} do
      conn = put conn, likes_path(conn, :update, likes), likes: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete likes" do
    setup [:create_likes]

    test "deletes chosen likes", %{conn: conn, likes: likes} do
      conn = delete conn, likes_path(conn, :delete, likes)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, likes_path(conn, :show, likes)
      end
    end
  end

  defp create_likes(_) do
    likes = fixture(:likes)
    {:ok, likes: likes}
  end
end
