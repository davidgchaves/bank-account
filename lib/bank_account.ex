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
    end
    await events
  end

  defp deposit(amount, events) do
    events ++ [{:deposit, amount}]
  end

  defp divulge_balance(pid, events) do
    send pid, {:balance, calculate_balance events}
  end

  defp calculate_balance(events) do
    sum events
  end

  defp sum(events) do
    Enum.reduce events, 0, fn({_, amount}, acc) -> acc + amount end
  end
end
