defmodule IconRent.Playground.Icon do
  use Ecto.Schema
  import Ecto.Changeset

  schema "icons" do
    field :name, :string
    field :address, :string
    field :description, :string
    field :verification_level, :string
    field :nullifier_hash, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(icon, attrs) do
    icon
    |> cast(attrs, [:name, :description, :verification_level, :address, :nullifier_hash])
    |> validate_required([:name, :description, :verification_level, :address, :nullifier_hash])
  end
end
