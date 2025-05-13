defmodule BbvaChallengeWeb.PaymentRequestJSON do
  alias BbvaChallenge.Payments.PaymentRequest

  @doc """
  Renders a list of payment_requests.
  """
  def index(%{payment_requests: payment_requests}) do
    %{data: for(payment_request <- payment_requests, do: data(payment_request))}
  end

  @doc """
  Renders a single payment_request.
  """
  def show(%{payment_request: payment_request}) do
    %{data: data(payment_request)}
  end

  defp data(%PaymentRequest{} = payment_request) do
    %{
      id: payment_request.id,
      amount: payment_request.amount,
      currency: payment_request.currency,
      status: payment_request.status,
      pay_url: payment_request.pay_url,
      qr_svg: payment_request.qr_svg
    }
  end
end
