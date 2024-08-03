defmodule IconRentWeb.IconLiveTest do
  use IconRentWeb.ConnCase

  import Phoenix.LiveViewTest
  import IconRent.PlaygroundFixtures

  @create_attrs %{name: "some name", address: "some address", description: "some description", verification_level: "some verification_level", nullifier_hash: "some nullifier_hash"}
  @update_attrs %{name: "some updated name", address: "some updated address", description: "some updated description", verification_level: "some updated verification_level", nullifier_hash: "some updated nullifier_hash"}
  @invalid_attrs %{name: nil, address: nil, description: nil, verification_level: nil, nullifier_hash: nil}

  defp create_icon(_) do
    icon = icon_fixture()
    %{icon: icon}
  end

  describe "Index" do
    setup [:create_icon]

    test "lists all icons", %{conn: conn, icon: icon} do
      {:ok, _index_live, html} = live(conn, ~p"/icons")

      assert html =~ "Listing Icons"
      assert html =~ icon.name
    end

    test "saves new icon", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/icons")

      assert index_live |> element("a", "New Icon") |> render_click() =~
               "New Icon"

      assert_patch(index_live, ~p"/icons/new")

      assert index_live
             |> form("#icon-form", icon: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#icon-form", icon: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/icons")

      html = render(index_live)
      assert html =~ "Icon created successfully"
      assert html =~ "some name"
    end

    test "updates icon in listing", %{conn: conn, icon: icon} do
      {:ok, index_live, _html} = live(conn, ~p"/icons")

      assert index_live |> element("#icons-#{icon.id} a", "Edit") |> render_click() =~
               "Edit Icon"

      assert_patch(index_live, ~p"/icons/#{icon}/edit")

      assert index_live
             |> form("#icon-form", icon: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#icon-form", icon: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/icons")

      html = render(index_live)
      assert html =~ "Icon updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes icon in listing", %{conn: conn, icon: icon} do
      {:ok, index_live, _html} = live(conn, ~p"/icons")

      assert index_live |> element("#icons-#{icon.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#icons-#{icon.id}")
    end
  end

  describe "Show" do
    setup [:create_icon]

    test "displays icon", %{conn: conn, icon: icon} do
      {:ok, _show_live, html} = live(conn, ~p"/icons/#{icon}")

      assert html =~ "Show Icon"
      assert html =~ icon.name
    end

    test "updates icon within modal", %{conn: conn, icon: icon} do
      {:ok, show_live, _html} = live(conn, ~p"/icons/#{icon}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Icon"

      assert_patch(show_live, ~p"/icons/#{icon}/show/edit")

      assert show_live
             |> form("#icon-form", icon: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#icon-form", icon: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/icons/#{icon}")

      html = render(show_live)
      assert html =~ "Icon updated successfully"
      assert html =~ "some updated name"
    end
  end
end
