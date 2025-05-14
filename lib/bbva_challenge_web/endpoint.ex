defmodule BbvaChallengeWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :bbva_challenge

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_bbva_challenge_key",
    signing_salt: "6Ub6N7qE",
    same_site: "Lax"
  ]

  # 1) Servir todos los assets estáticos del build de React / tus css/js
  plug Plug.Static,
    at: "/",
    from: :bbva_challenge,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt pay-ui)

  # 2) Luego tus uploads “dinámicos”
  plug Plug.Static,
    at: "/uploads",
    from: {:bbva_challenge, "priv/static/uploads"},
    gzip: false,
    cache_control_for_etags: "public, max-age=604800"

  # socket "/live", Phoenix.LiveView.Socket,
  #   websocket: [connect_info: [session: @session_options]],
  #   longpoll: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :bbva_challenge
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug BbvaChallengeWeb.Router
end
