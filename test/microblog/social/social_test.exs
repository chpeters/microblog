defmodule Microblog.SocialTest do
  use Microblog.DataCase

  alias Microblog.Social

  describe "messages" do
    alias Microblog.Social.Message

    @valid_attrs %{date: ~D[2010-04-17], likes: 42, message: "some message"}
    @update_attrs %{date: ~D[2011-05-18], likes: 43, message: "some updated message"}
    @invalid_attrs %{date: nil, likes: nil, message: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Social.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Social.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Social.create_message(@valid_attrs)
      assert message.date == ~D[2010-04-17]
      assert message.likes == 42
      assert message.message == "some message"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, message} = Social.update_message(message, @update_attrs)
      assert %Message{} = message
      assert message.date == ~D[2011-05-18]
      assert message.likes == 43
      assert message.message == "some updated message"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_message(message, @invalid_attrs)
      assert message == Social.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Social.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Social.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Social.change_message(message)
    end
  end
end
