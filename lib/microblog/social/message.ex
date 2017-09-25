defmodule Microblog.Social.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Social.Message


  schema "messages" do
    field :date, :date
    field :likes, :integer
    field :message, :string

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:message, :date, :likes])
    |> validate_required([:message, :date, :likes])
  end
end
