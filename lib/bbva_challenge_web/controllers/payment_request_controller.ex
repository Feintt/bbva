defmodule BbvaChallengeWeb.PaymentRequestController do
  use BbvaChallengeWeb, :controller

  alias BbvaChallenge.Payments
  alias BbvaChallenge.Payments.PaymentRequest
  alias BbvaChallenge.Pos
  alias EQRCode

  action_fallback BbvaChallengeWeb.FallbackController

  def index(conn, _params) do
    payment_requests = Payments.list_payment_requests()
    render(conn, :index, payment_requests: payment_requests)
  end

  def create(conn, %{"payment_request" => %{"amount" => amount}}) do
    user = conn.assigns.current_user

    with {:ok, cash_box} <- Pos.get_open_box(user.id) do
      id = Ecto.UUID.generate()
      pr_url = BbvaChallengeWeb.Endpoint.url() <> "/pay/sim/" <> id
      qr_svg = pr_url |> EQRCode.encode() |> EQRCode.svg()

      # 1) Primero creamos el registro SIN pay_url/qr_svg
      attrs = %{
        # pasamos el id manualmente
        id: id,
        amount: amount,
        currency: "MXN",
        pay_url: pr_url,
        qr_svg: qr_svg,
        account_id: cash_box.account_id,
        cash_box_id: cash_box.id,
        user_id: user.id
      }

      case Payments.create_payment_request(attrs) do
        {:ok, pr} ->
          # 2) Generamos la URL pública del checkout ficticio
          pr_url = BbvaChallengeWeb.Endpoint.url() <> "/pay/sim/" <> pr.id
          qr_svg = pr_url |> EQRCode.encode() |> EQRCode.svg()

          # 3) Actualizamos el registro con URL y QR definitivos
          {:ok, pr} =
            Payments.update_payment_request(pr, %{
              pay_url: pr_url,
              qr_svg: qr_svg
            })

          conn
          |> put_status(:created)
          |> render(:show, payment_request: pr)

        {:error, changeset} ->
          {:error, changeset}
      end
    else
      {:error, :no_open_box} ->
        conn |> put_status(:conflict) |> json(%{error: "Caja no abierta"})
    end
  end

  def show(conn, %{"id" => id}) do
    payment_request = Payments.get_payment_request!(id)
    render(conn, :show, payment_request: payment_request)
  end

  def update(conn, %{"id" => id, "payment_request" => payment_request_params}) do
    payment_request = Payments.get_payment_request!(id)

    with {:ok, %PaymentRequest{} = payment_request} <-
           Payments.update_payment_request(payment_request, payment_request_params) do
      render(conn, :show, payment_request: payment_request)
    end
  end

  def delete(conn, %{"id" => id}) do
    payment_request = Payments.get_payment_request!(id)

    with {:ok, %PaymentRequest{}} <- Payments.delete_payment_request(payment_request) do
      send_resp(conn, :no_content, "")
    end
  end
end
