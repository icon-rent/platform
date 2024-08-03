defmodule IconRentWeb.IconLive.FormComponent do
  use IconRentWeb, :live_component

  alias IconRent.Playground

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage icon records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="icon-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:verification_level]} type="text" label="Verification level" />
        <.input field={@form[:address]} type="text" label="Address" />
        <.input field={@form[:nullifier_hash]} type="text" label="Nullifier hash" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Icon</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{icon: icon} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Playground.change_icon(icon))
     end)}
  end

  @impl true
  def handle_event("validate", %{"icon" => icon_params}, socket) do
    changeset = Playground.change_icon(socket.assigns.icon, icon_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"icon" => icon_params}, socket) do
    save_icon(socket, socket.assigns.action, icon_params)
  end

  defp save_icon(socket, :edit, icon_params) do
    case Playground.update_icon(socket.assigns.icon, icon_params) do
      {:ok, icon} ->
        notify_parent({:saved, icon})

        {:noreply,
         socket
         |> put_flash(:info, "Icon updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_icon(socket, :new, icon_params) do
    case Playground.create_icon(icon_params) do
      {:ok, icon} ->
        notify_parent({:saved, icon})

        {:noreply,
         socket
         |> put_flash(:info, "Icon created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
