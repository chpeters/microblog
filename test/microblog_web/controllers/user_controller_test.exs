defmodule MicroblogWeb.UserControllerTest do
  use MicroblogWeb.ConnCase

  alias Microblog.Accounts

  @create_attrs %{name: "some name", username: "some username"}
  @update_attrs %{name: "some updated name", username: "some updated username"}
  @invalid_attrs %{name: nil, username: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get conn, user_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Users"
    end
  end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get conn, user_path(conn, :new)
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "create user" do

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "edit user" do
    setup [:create_user]
  end

  describe "update user" do
    setup [:create_user]
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
