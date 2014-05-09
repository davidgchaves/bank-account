defmodule BankAccount do
  use Application

  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    BankAccount.Supervisor.start_link
  end

  def start do
    await []
  end

  def await(events) do
    receive do
      {:check_balance, pid} -> divulge_balance pid, events
      {:deposit, amount}    -> events = deposit amount, events
      {:withdraw, amount}   -> events = withdraw amount, events
    end
    await events
  end

  defp divulge_balance(pid, events) do
    send pid, {:balance, calculate_balance events}
  end

  defp deposit(amount, events) do
    events ++ [{:deposit, amount}]
  end

  defp withdraw(amount, events) do
    events ++ [{:withdrawal, amount}]
  end

  defp calculate_balance(events) do
    sum_deposits(events) - sum_withdrawals(events)
  end

  defp sum_deposits(events) do
    sum just_deposits events
  end

  defp sum_withdrawals(events) do
    sum just_withdrawals events
  end

  defp just_deposits(events) do
    just_type events, :deposit
  end

  defp just_withdrawals(events) do
    just_type events, :withdrawal
  end

  defp just_type(events, expected_type) do
    Enum.filter events, fn({type, _}) -> type == expected_type end
  end

  defp sum(events) do
    Enum.reduce events, 0, fn({_, amount}, acc) -> acc + amount end
  end
end
