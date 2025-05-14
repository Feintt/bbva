defmodule BbvaChallengeWeb.PageController do
  use BbvaChallengeWeb, :controller

  def spa(conn, _params) do
    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, Application.app_dir(:bbva_challenge, "priv/static/pay-ui/index.html"))
  end
end
