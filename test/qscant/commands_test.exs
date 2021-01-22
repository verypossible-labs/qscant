defmodule QscanT.CommandsTest do
  use ExUnit.Case, async: true
  alias QscanT.Commands

  test "encode/2" do
    parameter = "X001"
    values = '1234'
    expected_command = "X0011234\r"
    assert {:ok, actual_command} = Commands.encode(parameter, values)
    assert expected_command == actual_command
  end

  test "control_card_lockout/1" do
    value = true
    expected_command = "X0391\r"
    assert {:ok, actual_command} = Commands.control_card_lockout(value)
    assert expected_command == actual_command
  end

  test "restart/0" do
    expected_command = "X0721\r"
    assert {:ok, actual_command} = Commands.restart()
    assert expected_command == actual_command
  end

  test "version/0" do
    expected_command = "V\r"
    assert {:ok, actual_command} = Commands.version()
    assert expected_command == actual_command
  end
end
