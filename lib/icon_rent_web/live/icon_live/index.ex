defmodule IconRentWeb.IconLive.Index do
  use IconRentWeb, :live_view

  alias IconRent.Playground
  alias IconRent.Playground.Icon

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :icons, Playground.list_icons())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Icon")
    |> assign(:icon, Playground.get_icon!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Icon")
    |> assign(:icon, %Icon{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Icons")
    |> assign(:icon, nil)
  end

  @impl true
  def handle_info({IconRentWeb.IconLive.FormComponent, {:saved, icon}}, socket) do
    {:noreply, stream_insert(socket, :icons, icon)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    icon = Playground.get_icon!(id)
    {:ok, _} = Playground.delete_icon(icon)

    {:noreply, stream_delete(socket, :icons, icon)}
  end
end
