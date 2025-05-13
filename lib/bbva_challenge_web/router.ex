defmodule BbvaChallengeWeb.Router do
  use BbvaChallengeWeb, :router

  import BbvaChallengeWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BbvaChallengeWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug :accepts, ["json"]
    plug :fetch_api_user
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:bbva_challenge, :dev_routes) do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/api", BbvaChallengeWeb do
    pipe_through [:api]
    post "/users/register", UserRegistrationController, :create
    post "/users/login", UserSessionController, :create
  end

  scope "/api", BbvaChallengeWeb do
    pipe_through :api_auth
    get "/users/me", UserSessionController, :get
    delete "/users/logout", UserSessionController, :delete
  end
end
