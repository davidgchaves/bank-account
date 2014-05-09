defmodule BankAccountTest do
  use ExUnit.Case

  test "starts off with a balance of 0" do
    account = spawn_link BankAccount, :start, []
    verify_balance_is 0, account
  end

  test "has balance incremented by the amount of a deposit" do
    account = spawn_link BankAccount, :start, []
    send account, {:deposit, 100}
    verify_balance_is 100, account
  end

  test "has balance decremented by the amount of a withdrawal" do
    account = spawn_link BankAccount, :start, []
    send account, {:deposit, 150}
    send account, {:withdraw, 100}
    verify_balance_is 50, account
  end

  defp verify_balance_is(expected_balance, actual_account) do
    send actual_account, {:check_balance, self}
    assert_receive {:balance, ^expected_balance}
  end
end
