defmodule IconRentWeb.Router do
  use IconRentWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {IconRentWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", IconRentWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/icons", IconLive.Index, :index
    live "/icons/new", IconLive.Index, :new
    live "/icons/:id/edit", IconLive.Index, :edit

    live "/icons/:id", IconLive.Show, :show
    live "/icons/:id/show/edit", IconLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", IconRentWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:icon_rent, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: IconRentWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
