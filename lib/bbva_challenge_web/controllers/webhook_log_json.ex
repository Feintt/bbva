defmodule BbvaChallengeWeb.WebhookLogJSON do
  alias BbvaChallenge.Payments.WebhookLog

  @doc """
  Renders a list of webhook_logs.
  """
  def index(%{webhook_logs: webhook_logs}) do
    %{data: for(webhook_log <- webhook_logs, do: data(webhook_log))}
  end

  @doc """
  Renders a single webhook_log.
  """
  def show(%{webhook_log: webhook_log}) do
    %{data: data(webhook_log)}
  end

  defp data(%WebhookLog{} = webhook_log) do
    %{
      id: webhook_log.id,
      provider: webhook_log.provider,
      payload: webhook_log.payload
    }
  end
end
