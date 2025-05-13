defmodule BbvaChallenge.PaymentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BbvaChallenge.Payments` context.
  """

  @doc """
  Generate a payment_request.
  """
  def payment_request_fixture(attrs \\ %{}) do
    {:ok, payment_request} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        currency: "some currency",
        pay_url: "some pay_url",
        qr_svg: "some qr_svg",
        status: "some status"
      })
      |> BbvaChallenge.Payments.create_payment_request()

    payment_request
  end

  @doc """
  Generate a webhook_log.
  """
  def webhook_log_fixture(attrs \\ %{}) do
    {:ok, webhook_log} =
      attrs
      |> Enum.into(%{
        payload: %{},
        provider: "some provider"
      })
      |> BbvaChallenge.Payments.create_webhook_log()

    webhook_log
  end
end
