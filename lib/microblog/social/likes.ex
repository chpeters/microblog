defmodule Microblog.Social.Likes do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Social.Likes


  schema "likes" do
    belongs_to :message, Microblog.Social.Message
    belongs_to :user, Microblog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Likes{} = likes, attrs) do
    likes
    |> cast(attrs, [:message_id, :user_id])
    |> validate_required([])
  end
end
