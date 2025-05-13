defmodule BbvaChallenge.Repo do
  use Ecto.Repo,
    otp_app: :bbva_challenge,
    adapter: Ecto.Adapters.Postgres
end
