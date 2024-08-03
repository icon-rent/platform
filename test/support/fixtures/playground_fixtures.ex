defmodule IconRent.PlaygroundFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IconRent.Playground` context.
  """

  @doc """
  Generate a icon.
  """
  def icon_fixture(attrs \\ %{}) do
    {:ok, icon} =
      attrs
      |> Enum.into(%{
        address: "some address",
        description: "some description",
        name: "some name",
        nullifier_hash: "some nullifier_hash",
        verification_level: "some verification_level"
      })
      |> IconRent.Playground.create_icon()

    icon
  end
end
