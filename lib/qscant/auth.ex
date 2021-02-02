defmodule QscanT.Auth do
  @moduledoc """
    Qscan Commands that do not require password authentication to use.
    Verbage and reference from the Qscan tcpx4.pdf reference.
    Reference revision date March 7, 2011
  """

  alias QscanT.Commands

  @doc """
    Request the reader's current IP Address, MAC address, and Reader ID
    seperated by a `:` Example format for a return sequence
    `192.168.1.55:aabbccddeeff:ibc reader`
  """
  @doc since: "0.1.0"
  def identify() do
    parameter = "IBCIDENTIFY"
    values = []
    Commands.encode(parameter, values)
  end

  @doc """
    Send the password to the reader to allow for all other control commands
    reader returns back an "OK" in response if password is valid.
    Password *MUST* be 5 characters long, or blank filled to be valid
    Default password is "11111"
  """
  @doc since: "0.1.0"
  def password(pass) do
    parameter = "PASS"
    values = String.to_charlist(pass)
    Commands.encode(parameter, values)
  end
end
