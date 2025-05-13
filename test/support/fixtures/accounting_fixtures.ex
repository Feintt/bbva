defmodule BbvaChallenge.AccountingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BbvaChallenge.Accounting` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        current_balance: "120.5",
        direction: "some direction",
        name: "some name"
      })
      |> BbvaChallenge.Accounting.create_account()

    account
  end

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        date: ~U[2025-05-12 19:39:00Z],
        description: "some description",
        kind: "some kind"
      })
      |> BbvaChallenge.Accounting.create_transaction()

    transaction
  end
end
