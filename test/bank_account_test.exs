defmodule BankAccountTest do
  use ExUnit.Case

  test "starts off with a balance of 0" do
    account = spawn_link BankAccount, :start, []
    send account, {:check_balance, self}
    assert_receive {:balance, 0}
  end

  test "has balance incremented by the amount of a deposit" do
    account = spawn_link BankAccount, :start, []
    send account, {:deposit, 100}
    send account, {:check_balance, self}
    assert_receive {:balance, 100}
  end
end
