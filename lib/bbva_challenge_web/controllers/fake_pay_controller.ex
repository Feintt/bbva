defmodule BbvaChallengeWeb.FakePayController do
  use BbvaChallengeWeb, :controller

  @react_index Path.join(:code.priv_dir(:bbva_challenge), "static/pay-ui/index.html")
  alias BbvaChallenge.Payments

  def show(conn, _params) do
    # Fíjate que “path” es un _array_ con todo lo que venga después de /sim/
    # pero como aquí sólo queremos servir index.html, lo ignoramos.

    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, @react_index)
  end

  def process(conn, %{"id" => id}) do
    payment = Payments.get_payment_request!(id)
    {:ok, _} = Payments.settle_payment(payment)

    # si quieres que la pantalla de éxito también sea React
    conn
    |> redirect(to: "/pay/sim/#{id}/success")
  end

  def success(conn, %{"id" => _id}) do
    # Si React maneja la pantalla de éxito, simplemente reenvías al index
    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, @react_index)
  end
end
