defmodule QscanT.AuthTest do
  use ExUnit.Case, async: true
  alias QscanT.Auth

  test "password/1" do
    parameter = "PASS"
    value = "11111"
    expected_command = parameter <> value <> "\r"

    assert {:ok, actual_command} = Auth.password(value)
    assert expected_command == actual_command
  end

  test "identify/0" do
    parameter = "IBCIDENTIFY"
    expected_command = parameter <> "\r"
    assert {:ok, actual_command} = Auth.identify()
    assert expected_command == actual_command
  end
end
