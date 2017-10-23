defmodule MicroblogWeb.MessageControllerTest do
  use MicroblogWeb.ConnCase

  alias Microblog.Social

  @create_attrs %{message: "some message"}
  @update_attrs %{message: "some updated message"}
  @invalid_attrs %{message: nil}

  def fixture(:message) do
    {:ok, message} = Social.create_message(@create_attrs)
    message
  end

  describe "index" do
  end

  describe "new message" do
  end

  describe "edit message" do
    setup [:create_message]
  end

  describe "update message" do
    setup [:create_message]

    test "redirects when data is valid", %{conn: conn, message: message} do
      conn = put conn, message_path(conn, :update, message), message: @update_attrs
      assert redirected_to(conn) == message_path(conn, :show, message)

      conn = get conn, message_path(conn, :show, message)
      assert html_response(conn, 200) =~ "some updated message"
    end
  end

  describe "delete message" do
    setup [:create_message]

    test "deletes chosen message", %{conn: conn, message: message} do
      conn = delete conn, message_path(conn, :delete, message)
      assert redirected_to(conn) == message_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, message_path(conn, :show, message)
      end
    end
  end

  defp create_message(_) do
    message = fixture(:message)
    {:ok, message: message}
  end
end
