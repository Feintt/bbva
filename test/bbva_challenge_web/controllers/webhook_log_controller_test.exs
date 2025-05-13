defmodule BbvaChallengeWeb.WebhookLogControllerTest do
  use BbvaChallengeWeb.ConnCase

  import BbvaChallenge.PaymentsFixtures

  alias BbvaChallenge.Payments.WebhookLog

  @create_attrs %{
    payload: %{},
    provider: "some provider"
  }
  @update_attrs %{
    payload: %{},
    provider: "some updated provider"
  }
  @invalid_attrs %{payload: nil, provider: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all webhook_logs", %{conn: conn} do
      conn = get(conn, ~p"/api/webhook_logs")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create webhook_log" do
    test "renders webhook_log when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/webhook_logs", webhook_log: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/webhook_logs/#{id}")

      assert %{
               "id" => ^id,
               "payload" => %{},
               "provider" => "some provider"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/webhook_logs", webhook_log: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update webhook_log" do
    setup [:create_webhook_log]

    test "renders webhook_log when data is valid", %{conn: conn, webhook_log: %WebhookLog{id: id} = webhook_log} do
      conn = put(conn, ~p"/api/webhook_logs/#{webhook_log}", webhook_log: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/webhook_logs/#{id}")

      assert %{
               "id" => ^id,
               "payload" => %{},
               "provider" => "some updated provider"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, webhook_log: webhook_log} do
      conn = put(conn, ~p"/api/webhook_logs/#{webhook_log}", webhook_log: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete webhook_log" do
    setup [:create_webhook_log]

    test "deletes chosen webhook_log", %{conn: conn, webhook_log: webhook_log} do
      conn = delete(conn, ~p"/api/webhook_logs/#{webhook_log}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/webhook_logs/#{webhook_log}")
      end
    end
  end

  defp create_webhook_log(_) do
    webhook_log = webhook_log_fixture()
    %{webhook_log: webhook_log}
  end
end
