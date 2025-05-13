defmodule BbvaChallengeWeb.PayProviderWebhookController do
  use BbvaChallengeWeb, :controller
  alias BbvaChallenge.Payments

  def handle(conn, %{
        "type" => "payment.succeeded",
        "data" => %{"metadata" => %{"payment_request_id" => pr_id}}
      }) do
    pr = Payments.get_payment_request!(pr_id)

    with {:ok, _} <- Payments.settle_payment(pr) do
      BbvaChallengeWeb.Endpoint.broadcast!("payments:#{pr.id}", "paid", %{})
      send_resp(conn, 200, "ok")
    end
  end
end
