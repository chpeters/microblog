defmodule Microblog.Social do
  @moduledoc """
  The Social context.
  """

  import Ecto.Query, warn: false
  alias Microblog.Repo

  alias Microblog.Social.Message

  @doc """
  Returns the list of messages.

  ## Examples

      iex> list_messages()
      [%Message{}, ...]

  """
  def list_messages do
    Repo.all(Message)
  end

  def list_messages_by_user_id(id) do
    query = from m in Message, where: m.user_id == ^id
    Repo.all(query)
  end

  def list_messages_by_user_ids(ids) do
    query = from m in Message, where: m.user_id in ^ids, preload: [:user]
    Repo.all(query)
  end

  @doc """
  Gets a single message.

  Raises `Ecto.NoResultsError` if the Message does not exist.

  ## Examples

      iex> get_message!(123)
      %Message{}

      iex> get_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_message!(id), do: Repo.get!(Message, id)

  @doc """
  Creates a message.

  ## Examples

      iex> create_message(%{field: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a message.

  ## Examples

      iex> update_message(message, %{field: new_value})
      {:ok, %Message{}}

      iex> update_message(message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Message.

  ## Examples

      iex> delete_message(message)
      {:ok, %Message{}}

      iex> delete_message(message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message changes.

  ## Examples

      iex> change_message(message)
      %Ecto.Changeset{source: %Message{}}

  """
  def change_message(%Message{} = message) do
    Message.changeset(message, %{})
  end

  alias Microblog.Social.Follow

  @doc """
  Returns the list of follows.

  ## Examples

      iex> list_follows()
      [%Follow{}, ...]

  """
  def list_follows do
    Repo.all(Follow)
  end

  def list_follows_by_follower_id(id) do 
    query = from f in Follow, where: f.follower_id == ^id
    Repo.all(query)
  end

  @doc """
  Gets a single follow.

  Raises `Ecto.NoResultsError` if the Follow does not exist.

  ## Examples

      iex> get_follow!(123)
      %Follow{}

      iex> get_follow!(456)
      ** (Ecto.NoResultsError)

  """
  def get_follow!(id), do: Repo.get!(Follow, id)

  @doc """
  Creates a follow.

  ## Examples

      iex> create_follow(%{field: value})
      {:ok, %Follow{}}

      iex> create_follow(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_follow(attrs \\ %{}) do
    %Follow{}
    |> Follow.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a follow.

  ## Examples

      iex> update_follow(follow, %{field: new_value})
      {:ok, %Follow{}}

      iex> update_follow(follow, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_follow(%Follow{} = follow, attrs) do
    follow
    |> Follow.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Follow.

  ## Examples

      iex> delete_follow(follow)
      {:ok, %Follow{}}

      iex> delete_follow(follow)
      {:error, %Ecto.Changeset{}}

  """
  def delete_follow(%Follow{} = follow) do
    Repo.delete(follow)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking follow changes.

  ## Examples

      iex> change_follow(follow)
      %Ecto.Changeset{source: %Follow{}}

  """
  def change_follow(%Follow{} = follow) do
    Follow.changeset(follow, %{})
  end

  alias Microblog.Social.Likes

  @doc """
  Returns the list of likes.

  ## Examples

      iex> list_likes()
      [%Likes{}, ...]

  """
  def list_likes do
    Repo.all(Likes)
  end

  @doc """
  Gets a single likes.

  Raises `Ecto.NoResultsError` if the Likes does not exist.

  ## Examples

      iex> get_likes!(123)
      %Likes{}

      iex> get_likes!(456)
      ** (Ecto.NoResultsError)

  """
  def get_likes!(id), do: Repo.get!(Likes, id)

  def get_number_likes_by_message_id(id) do
    query = from l in Likes, where: l.message_id == ^id, select: count(l.id)
    Repo.one(query)
  end

  def get_likes_by_message_id(id) do
    query = from l in Likes, where: l.message_id == ^id
    result = Repo.one(query)
    if result do
      Repo.preload(result, :message)
    else
      nil
    end
  end

  @doc """
  Creates a likes.

  ## Examples

      iex> create_likes(%{field: value})
      {:ok, %Likes{}}

      iex> create_likes(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_likes(attrs \\ %{}) do
    %Likes{}
    |> Likes.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a likes.

  ## Examples

      iex> update_likes(likes, %{field: new_value})
      {:ok, %Likes{}}

      iex> update_likes(likes, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_likes(%Likes{} = likes, attrs) do
    likes
    |> Likes.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Likes.

  ## Examples

      iex> delete_likes(likes)
      {:ok, %Likes{}}

      iex> delete_likes(likes)
      {:error, %Ecto.Changeset{}}

  """
  def delete_likes(%Likes{} = likes) do
    Repo.delete(likes)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking likes changes.

  ## Examples

      iex> change_likes(likes)
      %Ecto.Changeset{source: %Likes{}}

  """
  def change_likes(%Likes{} = likes) do
    Likes.changeset(likes, %{})
  end
end
