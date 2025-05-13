defmodule BbvaChallengeWeb.WebhookLogController do
  use BbvaChallengeWeb, :controller

  alias BbvaChallenge.Payments
  alias BbvaChallenge.Payments.WebhookLog

  action_fallback BbvaChallengeWeb.FallbackController

  def index(conn, _params) do
    webhook_logs = Payments.list_webhook_logs()
    render(conn, :index, webhook_logs: webhook_logs)
  end

  def create(conn, %{"webhook_log" => webhook_log_params}) do
    with {:ok, %WebhookLog{} = webhook_log} <- Payments.create_webhook_log(webhook_log_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/webhook_logs/#{webhook_log}")
      |> render(:show, webhook_log: webhook_log)
    end
  end

  def show(conn, %{"id" => id}) do
    webhook_log = Payments.get_webhook_log!(id)
    render(conn, :show, webhook_log: webhook_log)
  end

  def update(conn, %{"id" => id, "webhook_log" => webhook_log_params}) do
    webhook_log = Payments.get_webhook_log!(id)

    with {:ok, %WebhookLog{} = webhook_log} <- Payments.update_webhook_log(webhook_log, webhook_log_params) do
      render(conn, :show, webhook_log: webhook_log)
    end
  end

  def delete(conn, %{"id" => id}) do
    webhook_log = Payments.get_webhook_log!(id)

    with {:ok, %WebhookLog{}} <- Payments.delete_webhook_log(webhook_log) do
      send_resp(conn, :no_content, "")
    end
  end
end
