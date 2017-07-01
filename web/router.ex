defmodule SpectoPusher.Router do
  use SpectoPusher.Web, :router
  use ExAdmin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SpectoPusher do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", SpectoPusher do
    pipe_through :api
    resources "/channels", ChannelController, except: [:new, :edit]
  end

  scope "/admin", ExAdmin do
    pipe_through :browser
    admin_routes()
  end
end
