defmodule BbvaChallenge.PaymentsTest do
  use BbvaChallenge.DataCase

  alias BbvaChallenge.Payments

  describe "payment_requests" do
    alias BbvaChallenge.Payments.PaymentRequest

    import BbvaChallenge.PaymentsFixtures

    @invalid_attrs %{status: nil, currency: nil, amount: nil, pay_url: nil, qr_svg: nil}

    test "list_payment_requests/0 returns all payment_requests" do
      payment_request = payment_request_fixture()
      assert Payments.list_payment_requests() == [payment_request]
    end

    test "get_payment_request!/1 returns the payment_request with given id" do
      payment_request = payment_request_fixture()
      assert Payments.get_payment_request!(payment_request.id) == payment_request
    end

    test "create_payment_request/1 with valid data creates a payment_request" do
      valid_attrs = %{status: "some status", currency: "some currency", amount: "120.5", pay_url: "some pay_url", qr_svg: "some qr_svg"}

      assert {:ok, %PaymentRequest{} = payment_request} = Payments.create_payment_request(valid_attrs)
      assert payment_request.status == "some status"
      assert payment_request.currency == "some currency"
      assert payment_request.amount == Decimal.new("120.5")
      assert payment_request.pay_url == "some pay_url"
      assert payment_request.qr_svg == "some qr_svg"
    end

    test "create_payment_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Payments.create_payment_request(@invalid_attrs)
    end

    test "update_payment_request/2 with valid data updates the payment_request" do
      payment_request = payment_request_fixture()
      update_attrs = %{status: "some updated status", currency: "some updated currency", amount: "456.7", pay_url: "some updated pay_url", qr_svg: "some updated qr_svg"}

      assert {:ok, %PaymentRequest{} = payment_request} = Payments.update_payment_request(payment_request, update_attrs)
      assert payment_request.status == "some updated status"
      assert payment_request.currency == "some updated currency"
      assert payment_request.amount == Decimal.new("456.7")
      assert payment_request.pay_url == "some updated pay_url"
      assert payment_request.qr_svg == "some updated qr_svg"
    end

    test "update_payment_request/2 with invalid data returns error changeset" do
      payment_request = payment_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Payments.update_payment_request(payment_request, @invalid_attrs)
      assert payment_request == Payments.get_payment_request!(payment_request.id)
    end

    test "delete_payment_request/1 deletes the payment_request" do
      payment_request = payment_request_fixture()
      assert {:ok, %PaymentRequest{}} = Payments.delete_payment_request(payment_request)
      assert_raise Ecto.NoResultsError, fn -> Payments.get_payment_request!(payment_request.id) end
    end

    test "change_payment_request/1 returns a payment_request changeset" do
      payment_request = payment_request_fixture()
      assert %Ecto.Changeset{} = Payments.change_payment_request(payment_request)
    end
  end

  describe "webhook_logs" do
    alias BbvaChallenge.Payments.WebhookLog

    import BbvaChallenge.PaymentsFixtures

    @invalid_attrs %{payload: nil, provider: nil}

    test "list_webhook_logs/0 returns all webhook_logs" do
      webhook_log = webhook_log_fixture()
      assert Payments.list_webhook_logs() == [webhook_log]
    end

    test "get_webhook_log!/1 returns the webhook_log with given id" do
      webhook_log = webhook_log_fixture()
      assert Payments.get_webhook_log!(webhook_log.id) == webhook_log
    end

    test "create_webhook_log/1 with valid data creates a webhook_log" do
      valid_attrs = %{payload: %{}, provider: "some provider"}

      assert {:ok, %WebhookLog{} = webhook_log} = Payments.create_webhook_log(valid_attrs)
      assert webhook_log.payload == %{}
      assert webhook_log.provider == "some provider"
    end

    test "create_webhook_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Payments.create_webhook_log(@invalid_attrs)
    end

    test "update_webhook_log/2 with valid data updates the webhook_log" do
      webhook_log = webhook_log_fixture()
      update_attrs = %{payload: %{}, provider: "some updated provider"}

      assert {:ok, %WebhookLog{} = webhook_log} = Payments.update_webhook_log(webhook_log, update_attrs)
      assert webhook_log.payload == %{}
      assert webhook_log.provider == "some updated provider"
    end

    test "update_webhook_log/2 with invalid data returns error changeset" do
      webhook_log = webhook_log_fixture()
      assert {:error, %Ecto.Changeset{}} = Payments.update_webhook_log(webhook_log, @invalid_attrs)
      assert webhook_log == Payments.get_webhook_log!(webhook_log.id)
    end

    test "delete_webhook_log/1 deletes the webhook_log" do
      webhook_log = webhook_log_fixture()
      assert {:ok, %WebhookLog{}} = Payments.delete_webhook_log(webhook_log)
      assert_raise Ecto.NoResultsError, fn -> Payments.get_webhook_log!(webhook_log.id) end
    end

    test "change_webhook_log/1 returns a webhook_log changeset" do
      webhook_log = webhook_log_fixture()
      assert %Ecto.Changeset{} = Payments.change_webhook_log(webhook_log)
    end
  end
end
