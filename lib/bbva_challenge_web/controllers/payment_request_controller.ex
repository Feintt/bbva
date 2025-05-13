defmodule BbvaChallengeWeb.PaymentRequestController do
  use BbvaChallengeWeb, :controller

  alias BbvaChallenge.Payments
  alias BbvaChallenge.Payments.PaymentRequest
  alias BbvaChallenge.Pos
  alias BbvaChallenge.Payments.PayProvider
  alias EQRCode

  action_fallback BbvaChallengeWeb.FallbackController

  def index(conn, _params) do
    payment_requests = Payments.list_payment_requests()
    render(conn, :index, payment_requests: payment_requests)
  end

  def create(conn, %{"payment_request" => %{"amount" => amount}}) do
    user = conn.assigns.current_user

    with {:ok, cash_box} <- Pos.get_open_box(user.id),
         {:ok, pay_url} <-
           PayProvider.create_session(%{
             amount: amount,
             currency: "MXN",
             metadata: %{user_id: user.id, box_id: cash_box.id}
           }) do
      qr_svg = pay_url |> EQRCode.encode() |> EQRCode.svg()

      attrs = %{
        amount: amount,
        currency: "MXN",
        pay_url: pay_url,
        qr_svg: qr_svg,
        account_id: cash_box.account_id,
        cash_box_id: cash_box.id,
        user_id: user.id
      }

      case Payments.create_payment_request(attrs) do
        {:ok, pr} ->
          conn
          |> put_status(:created)
          |> render(:show, payment_request: pr)

        {:error, changeset} ->
          conn |> put_status(:unprocessable_entity) |> render(:error, changeset: changeset)
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
