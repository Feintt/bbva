defmodule BbvaChallenge.Payments.PayProvider do
  @moduledoc "Wrapper mínimo para el proveedor de pagos (demo)."

  @doc """
  Simula la creación de una sesión de pago.
  """
  def create_session(%{amount: amount, currency: _cur} = _attrs) when amount > 0 do
    # En producción, llama a Stripe/MercadoPago/Codi aquí
    fake_url = "https://pay.demo/#{Ecto.UUID.generate()}"
    {:ok, fake_url}
  end
end
