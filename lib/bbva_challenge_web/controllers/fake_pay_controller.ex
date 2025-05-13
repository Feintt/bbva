defmodule BbvaChallengeWeb.FakePayController do
  use BbvaChallengeWeb, :controller
  # si usas HTML completo en las plantillas
  plug :put_layout, false

  alias BbvaChallenge.Payments

  def show(conn, %{"id" => id}) do
    payment =
      Payments.get_payment_request!(id)
      |> BbvaChallenge.Repo.preload(:account)

    conn
    |> put_view(BbvaChallengeWeb.FakePayHTML)
    |> render(:show, payment: payment)
  end

  def process(conn, %{"id" => id}) do
    payment = Payments.get_payment_request!(id)
    {:ok, _} = Payments.settle_payment(payment)
    redirect(conn, to: ~p"/pay/sim/#{id}/success")
  end

  def success(conn, %{"id" => _id}) do
    render(conn, BbvaChallengeWeb.FakePayHTML, :success, %{})
  end
end
