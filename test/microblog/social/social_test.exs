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

  describe "follows" do
    alias Microblog.Social.Follow

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def follow_fixture(attrs \\ %{}) do
      {:ok, follow} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_follow()

      follow
    end

    test "list_follows/0 returns all follows" do
      follow = follow_fixture()
      assert Social.list_follows() == [follow]
    end

    test "get_follow!/1 returns the follow with given id" do
      follow = follow_fixture()
      assert Social.get_follow!(follow.id) == follow
    end

    test "create_follow/1 with valid data creates a follow" do
      assert {:ok, %Follow{} = follow} = Social.create_follow(@valid_attrs)
    end

    test "create_follow/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_follow(@invalid_attrs)
    end

    test "update_follow/2 with valid data updates the follow" do
      follow = follow_fixture()
      assert {:ok, follow} = Social.update_follow(follow, @update_attrs)
      assert %Follow{} = follow
    end

    test "update_follow/2 with invalid data returns error changeset" do
      follow = follow_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_follow(follow, @invalid_attrs)
      assert follow == Social.get_follow!(follow.id)
    end

    test "delete_follow/1 deletes the follow" do
      follow = follow_fixture()
      assert {:ok, %Follow{}} = Social.delete_follow(follow)
      assert_raise Ecto.NoResultsError, fn -> Social.get_follow!(follow.id) end
    end

    test "change_follow/1 returns a follow changeset" do
      follow = follow_fixture()
      assert %Ecto.Changeset{} = Social.change_follow(follow)
    end
  end

  describe "likes" do
    alias Microblog.Social.Likes

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def likes_fixture(attrs \\ %{}) do
      {:ok, likes} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_likes()

      likes
    end

    test "list_likes/0 returns all likes" do
      likes = likes_fixture()
      assert Social.list_likes() == [likes]
    end

    test "get_likes!/1 returns the likes with given id" do
      likes = likes_fixture()
      assert Social.get_likes!(likes.id) == likes
    end

    test "create_likes/1 with valid data creates a likes" do
      assert {:ok, %Likes{} = likes} = Social.create_likes(@valid_attrs)
    end

    test "create_likes/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_likes(@invalid_attrs)
    end

    test "update_likes/2 with valid data updates the likes" do
      likes = likes_fixture()
      assert {:ok, likes} = Social.update_likes(likes, @update_attrs)
      assert %Likes{} = likes
    end

    test "update_likes/2 with invalid data returns error changeset" do
      likes = likes_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_likes(likes, @invalid_attrs)
      assert likes == Social.get_likes!(likes.id)
    end

    test "delete_likes/1 deletes the likes" do
      likes = likes_fixture()
      assert {:ok, %Likes{}} = Social.delete_likes(likes)
      assert_raise Ecto.NoResultsError, fn -> Social.get_likes!(likes.id) end
    end

    test "change_likes/1 returns a likes changeset" do
      likes = likes_fixture()
      assert %Ecto.Changeset{} = Social.change_likes(likes)
    end
  end
end
