defmodule IconRent.Playground do
  @moduledoc """
  The Playground context.
  """

  import Ecto.Query, warn: false
  alias IconRent.Repo

  alias IconRent.Playground.Icon

  @doc """
  Returns the list of icons.

  ## Examples

      iex> list_icons()
      [%Icon{}, ...]

  """
  def list_icons do
    Repo.all(Icon)
  end

  @doc """
  Gets a single icon.

  Raises `Ecto.NoResultsError` if the Icon does not exist.

  ## Examples

      iex> get_icon!(123)
      %Icon{}

      iex> get_icon!(456)
      ** (Ecto.NoResultsError)

  """
  def get_icon!(id), do: Repo.get!(Icon, id)

  @doc """
  Creates a icon.

  ## Examples

      iex> create_icon(%{field: value})
      {:ok, %Icon{}}

      iex> create_icon(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_icon(attrs \\ %{}) do
    %Icon{}
    |> Icon.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a icon.

  ## Examples

      iex> update_icon(icon, %{field: new_value})
      {:ok, %Icon{}}

      iex> update_icon(icon, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_icon(%Icon{} = icon, attrs) do
    icon
    |> Icon.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a icon.

  ## Examples

      iex> delete_icon(icon)
      {:ok, %Icon{}}

      iex> delete_icon(icon)
      {:error, %Ecto.Changeset{}}

  """
  def delete_icon(%Icon{} = icon) do
    Repo.delete(icon)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking icon changes.

  ## Examples

      iex> change_icon(icon)
      %Ecto.Changeset{data: %Icon{}}

  """
  def change_icon(%Icon{} = icon, attrs \\ %{}) do
    Icon.changeset(icon, attrs)
  end
end
