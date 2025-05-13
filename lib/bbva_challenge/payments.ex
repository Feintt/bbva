defmodule BbvaChallenge.Payments do
  @moduledoc """
  The Payments context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Multi

  alias BbvaChallenge.Repo
  alias BbvaChallenge.Payments.PaymentRequest
  alias BbvaChallenge.{Pos, Accounting, Accounts}

  @doc """
  Crea un PaymentRequest y devuelve la estructura con el QR listo.
  """
  def create_payment(%{
        amount: amount,
        account: %Accounting.Account{} = account,
        cash_box: %Pos.CashBox{} = box,
        user: %Accounts.User{} = user,
        pay_url: url,
        qr_svg: svg
      }) do
    %PaymentRequest{}
    |> PaymentRequest.changeset(%{
      amount: amount,
      pay_url: url,
      qr_svg: svg,
      account_id: account.id,
      cash_box_id: box.id,
      user_id: user.id
    })
    |> Repo.insert()
  end

  @doc """
  Marca un PaymentRequest como pagado y genera el asiento + apunte
  en una sola transacción.
  """
  def settle_payment(%PaymentRequest{} = pr) do
    Multi.new()
    |> Multi.update(
      :mark_paid,
      Ecto.Changeset.change(pr, status: :paid)
    )
    |> Multi.run(:transaction, fn _repo, _ ->
      Accounting.create_transaction(%{
        kind: :ingreso,
        amount: pr.amount,
        description: "QR payment #{pr.id}",
        date: DateTime.utc_now(),
        account_id: pr.account_id,
        user_id: pr.user_id
      })
    end)
    |> Multi.run(:cash_movement, fn _repo, %{transaction: trx} ->
      Pos.create_cash_movement(%{
        type: :ingreso,
        payment_method: :efectivo,
        amount: pr.amount,
        description: "QR payment #{pr.id}",
        date: DateTime.utc_now(),
        cash_box_id: pr.cash_box_id,
        transaction_id: trx.id,
        payment_request_id: pr.id
      })
    end)
    |> Repo.transaction()
  end

  @doc """
  Returns the list of payment_requests.

  ## Examples

      iex> list_payment_requests()
      [%PaymentRequest{}, ...]

  """
  def list_payment_requests do
    Repo.all(PaymentRequest)
  end

  @doc """
  Gets a single payment_request.

  Raises `Ecto.NoResultsError` if the Payment request does not exist.

  ## Examples

      iex> get_payment_request!(123)
      %PaymentRequest{}

      iex> get_payment_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_payment_request!(id), do: Repo.get!(PaymentRequest, id)

  @doc """
  Creates a payment_request.

  ## Examples

      iex> create_payment_request(%{field: value})
      {:ok, %PaymentRequest{}}

      iex> create_payment_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_payment_request(attrs \\ %{}) do
    %PaymentRequest{}
    |> PaymentRequest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a payment_request.

  ## Examples

      iex> update_payment_request(payment_request, %{field: new_value})
      {:ok, %PaymentRequest{}}

      iex> update_payment_request(payment_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_payment_request(%PaymentRequest{} = payment_request, attrs) do
    payment_request
    |> PaymentRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a payment_request.

  ## Examples

      iex> delete_payment_request(payment_request)
      {:ok, %PaymentRequest{}}

      iex> delete_payment_request(payment_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_payment_request(%PaymentRequest{} = payment_request) do
    Repo.delete(payment_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking payment_request changes.

  ## Examples

      iex> change_payment_request(payment_request)
      %Ecto.Changeset{data: %PaymentRequest{}}

  """
  def change_payment_request(%PaymentRequest{} = payment_request, attrs \\ %{}) do
    PaymentRequest.changeset(payment_request, attrs)
  end

  alias BbvaChallenge.Payments.WebhookLog

  @doc """
  Returns the list of webhook_logs.

  ## Examples

      iex> list_webhook_logs()
      [%WebhookLog{}, ...]

  """
  def list_webhook_logs do
    Repo.all(WebhookLog)
  end

  @doc """
  Gets a single webhook_log.

  Raises `Ecto.NoResultsError` if the Webhook log does not exist.

  ## Examples

      iex> get_webhook_log!(123)
      %WebhookLog{}

      iex> get_webhook_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_webhook_log!(id), do: Repo.get!(WebhookLog, id)

  @doc """
  Creates a webhook_log.

  ## Examples

      iex> create_webhook_log(%{field: value})
      {:ok, %WebhookLog{}}

      iex> create_webhook_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_webhook_log(attrs \\ %{}) do
    %WebhookLog{}
    |> WebhookLog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a webhook_log.

  ## Examples

      iex> update_webhook_log(webhook_log, %{field: new_value})
      {:ok, %WebhookLog{}}

      iex> update_webhook_log(webhook_log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_webhook_log(%WebhookLog{} = webhook_log, attrs) do
    webhook_log
    |> WebhookLog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a webhook_log.

  ## Examples

      iex> delete_webhook_log(webhook_log)
      {:ok, %WebhookLog{}}

      iex> delete_webhook_log(webhook_log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_webhook_log(%WebhookLog{} = webhook_log) do
    Repo.delete(webhook_log)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking webhook_log changes.

  ## Examples

      iex> change_webhook_log(webhook_log)
      %Ecto.Changeset{data: %WebhookLog{}}

  """
  def change_webhook_log(%WebhookLog{} = webhook_log, attrs \\ %{}) do
    WebhookLog.changeset(webhook_log, attrs)
  end
end
