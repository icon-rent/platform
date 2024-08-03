defmodule IconRentWeb.IconLive.Show do
  use IconRentWeb, :live_view

  alias IconRent.Playground

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:icon, Playground.get_icon!(id))}
  end

  defp page_title(:show), do: "Show Icon"
  defp page_title(:edit), do: "Edit Icon"
end
