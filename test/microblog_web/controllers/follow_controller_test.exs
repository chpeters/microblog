defmodule MicroblogWeb.FollowControllerTest do
  use MicroblogWeb.ConnCase

  alias Microblog.Social

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:follow) do
    {:ok, follow} = Social.create_follow(@create_attrs)
    follow
  end

  describe "new follow" do
    test "renders form", %{conn: conn} do
      conn = get conn, follow_path(conn, :new)
      assert html_response(conn, 200) =~ "New Follow"
    end
  end

  describe "edit follow" do
    setup [:create_follow]

    test "renders form for editing chosen follow", %{conn: conn, follow: follow} do
      conn = get conn, follow_path(conn, :edit, follow)
      assert html_response(conn, 200) =~ "Edit Follow"
    end
  end

  describe "update follow" do
    setup [:create_follow]

    test "redirects when data is valid", %{conn: conn, follow: follow} do
      conn = put conn, follow_path(conn, :update, follow), follow: @update_attrs
      assert redirected_to(conn) == follow_path(conn, :show, follow)

      conn = get conn, follow_path(conn, :show, follow)
      assert html_response(conn, 200)
    end
  end

  describe "delete follow" do
    setup [:create_follow]

    test "deletes chosen follow", %{conn: conn, follow: follow} do
      conn = delete conn, follow_path(conn, :delete, follow)
      assert redirected_to(conn) == follow_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, follow_path(conn, :show, follow)
      end
    end
  end

  defp create_follow(_) do
    follow = fixture(:follow)
    {:ok, follow: follow}
  end
end
