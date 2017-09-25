defmodule Microblog.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :message, :string
      add :date, :date
      add :likes, :integer

      timestamps()
    end

  end
end
