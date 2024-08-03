defmodule IconRent.PlaygroundTest do
  use IconRent.DataCase

  alias IconRent.Playground

  describe "icons" do
    alias IconRent.Playground.Icon

    import IconRent.PlaygroundFixtures

    @invalid_attrs %{name: nil, address: nil, description: nil, verification_level: nil, nullifier_hash: nil}

    test "list_icons/0 returns all icons" do
      icon = icon_fixture()
      assert Playground.list_icons() == [icon]
    end

    test "get_icon!/1 returns the icon with given id" do
      icon = icon_fixture()
      assert Playground.get_icon!(icon.id) == icon
    end

    test "create_icon/1 with valid data creates a icon" do
      valid_attrs = %{name: "some name", address: "some address", description: "some description", verification_level: "some verification_level", nullifier_hash: "some nullifier_hash"}

      assert {:ok, %Icon{} = icon} = Playground.create_icon(valid_attrs)
      assert icon.name == "some name"
      assert icon.address == "some address"
      assert icon.description == "some description"
      assert icon.verification_level == "some verification_level"
      assert icon.nullifier_hash == "some nullifier_hash"
    end

    test "create_icon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Playground.create_icon(@invalid_attrs)
    end

    test "update_icon/2 with valid data updates the icon" do
      icon = icon_fixture()
      update_attrs = %{name: "some updated name", address: "some updated address", description: "some updated description", verification_level: "some updated verification_level", nullifier_hash: "some updated nullifier_hash"}

      assert {:ok, %Icon{} = icon} = Playground.update_icon(icon, update_attrs)
      assert icon.name == "some updated name"
      assert icon.address == "some updated address"
      assert icon.description == "some updated description"
      assert icon.verification_level == "some updated verification_level"
      assert icon.nullifier_hash == "some updated nullifier_hash"
    end

    test "update_icon/2 with invalid data returns error changeset" do
      icon = icon_fixture()
      assert {:error, %Ecto.Changeset{}} = Playground.update_icon(icon, @invalid_attrs)
      assert icon == Playground.get_icon!(icon.id)
    end

    test "delete_icon/1 deletes the icon" do
      icon = icon_fixture()
      assert {:ok, %Icon{}} = Playground.delete_icon(icon)
      assert_raise Ecto.NoResultsError, fn -> Playground.get_icon!(icon.id) end
    end

    test "change_icon/1 returns a icon changeset" do
      icon = icon_fixture()
      assert %Ecto.Changeset{} = Playground.change_icon(icon)
    end
  end
end
