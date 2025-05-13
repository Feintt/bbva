defmodule BbvaChallenge.Payments.PayProvider do
  @moduledoc "Wrapper mínimo para el proveedor de pagos (demo)."

  alias BbvaChallengeWeb.Endpoint, as: Ep

  def create_session(%{amount: amount} = _attrs) when amount > 0 do
    # Generate local URL that hosts the fake form
    {:ok, Ep.url() <> "/pay/sim/" <> Ecto.UUID.generate()}
  end

  @doc """
  Simula la creación de una sesión de pago.
  """
  def create_session(%{amount: amount, currency: _cur} = _attrs) when amount > 0 do
    # En producción, llama a Stripe/MercadoPago/Codi aquí
    fake_url = "https://pay.demo/#{Ecto.UUID.generate()}"
    {:ok, fake_url}
  end
end
