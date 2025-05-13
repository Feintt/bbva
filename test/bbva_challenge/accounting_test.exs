defmodule BbvaChallenge.AccountingTest do
  use BbvaChallenge.DataCase

  alias BbvaChallenge.Accounting

  describe "accounts" do
    alias BbvaChallenge.Accounting.Account

    import BbvaChallenge.AccountingFixtures

    @invalid_attrs %{name: nil, direction: nil, " ": nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounting.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounting.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{name: "some name", direction: "some direction", " ": "some  "}

      assert {:ok, %Account{} = account} = Accounting.create_account(valid_attrs)
      assert account.name == "some name"
      assert account.direction == "some direction"
      assert account.  == "some  "
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounting.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{name: "some updated name", direction: "some updated direction", " ": "some updated  "}

      assert {:ok, %Account{} = account} = Accounting.update_account(account, update_attrs)
      assert account.name == "some updated name"
      assert account.direction == "some updated direction"
      assert account.  == "some updated  "
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounting.update_account(account, @invalid_attrs)
      assert account == Accounting.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounting.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounting.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounting.change_account(account)
    end
  end

  describe "accounts" do
    alias BbvaChallenge.Accounting.Account

    import BbvaChallenge.AccountingFixtures

    @invalid_attrs %{name: nil, direction: nil, current_balance: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounting.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounting.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{name: "some name", direction: "some direction", current_balance: "120.5"}

      assert {:ok, %Account{} = account} = Accounting.create_account(valid_attrs)
      assert account.name == "some name"
      assert account.direction == "some direction"
      assert account.current_balance == Decimal.new("120.5")
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounting.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{name: "some updated name", direction: "some updated direction", current_balance: "456.7"}

      assert {:ok, %Account{} = account} = Accounting.update_account(account, update_attrs)
      assert account.name == "some updated name"
      assert account.direction == "some updated direction"
      assert account.current_balance == Decimal.new("456.7")
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounting.update_account(account, @invalid_attrs)
      assert account == Accounting.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounting.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounting.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounting.change_account(account)
    end
  end

  describe "transactions" do
    alias BbvaChallenge.Accounting.Transaction

    import BbvaChallenge.AccountingFixtures

    @invalid_attrs %{date: nil, description: nil, kind: nil, amount: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Accounting.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Accounting.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{date: ~U[2025-05-12 19:39:00Z], description: "some description", kind: "some kind", amount: "120.5"}

      assert {:ok, %Transaction{} = transaction} = Accounting.create_transaction(valid_attrs)
      assert transaction.date == ~U[2025-05-12 19:39:00Z]
      assert transaction.description == "some description"
      assert transaction.kind == "some kind"
      assert transaction.amount == Decimal.new("120.5")
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounting.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{date: ~U[2025-05-13 19:39:00Z], description: "some updated description", kind: "some updated kind", amount: "456.7"}

      assert {:ok, %Transaction{} = transaction} = Accounting.update_transaction(transaction, update_attrs)
      assert transaction.date == ~U[2025-05-13 19:39:00Z]
      assert transaction.description == "some updated description"
      assert transaction.kind == "some updated kind"
      assert transaction.amount == Decimal.new("456.7")
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounting.update_transaction(transaction, @invalid_attrs)
      assert transaction == Accounting.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Accounting.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Accounting.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Accounting.change_transaction(transaction)
    end
  end
end
