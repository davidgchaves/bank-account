defmodule BankAccountTest do
  use ExUnit.Case

  test "starts off with a balance of 0" do
    account = spawn_link BankAccount, :start, []
    send account, {:check_balance, self}
    assert_receive {:balance, 0}
  end
end
