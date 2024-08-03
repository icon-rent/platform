defmodule IconRent.Repo.Migrations.CreateIcons do
  use Ecto.Migration

  def change do
    create table(:icons) do
      add :name, :string
      add :description, :string
      add :verification_level, :string
      add :address, :string
      add :nullifier_hash, :string

      timestamps(type: :utc_datetime)
    end
  end
end
