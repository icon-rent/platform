defmodule IconRent.Repo do
  use Ecto.Repo,
    otp_app: :icon_rent,
    adapter: Ecto.Adapters.Postgres
end
