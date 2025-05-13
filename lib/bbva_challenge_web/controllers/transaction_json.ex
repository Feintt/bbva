defmodule BbvaChallengeWeb.TransactionJSON do
  alias BbvaChallenge.Accounting.Transaction

  @doc """
  Renders a list of transactions.
  """
  def index(%{transactions: transactions}) do
    %{data: for(transaction <- transactions, do: data(transaction))}
  end

  @doc """
  Renders a single transaction.
  """
  def show(%{transaction: transaction}) do
    %{data: data(transaction)}
  end

  defp data(%Transaction{} = transaction) do
    %{
      id: transaction.id,
      amount: transaction.amount,
      kind: transaction.kind,
      description: transaction.description,
      date: transaction.date
    }
  end
end
