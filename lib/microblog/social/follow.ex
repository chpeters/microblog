defmodule Microblog.Social.Follow do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Social.Follow


  schema "follows" do
    field :follower_id, :id
    field :followee_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Follow{} = follow, attrs) do
    follow
    |> cast(attrs, [:follower_id, :followee_id])
    |> validate_required([])
  end
end
