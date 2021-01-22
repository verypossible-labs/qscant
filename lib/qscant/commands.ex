defmodule QscanT.Commands do
  @moduledoc """
    Qscan Commands. Verbage and reference from the qscan203.pdf reference.
    Reference revision date February 26, 2019
  """

  @doc """
  Generates a binary with the given parameter string, and an array of values.

  Returns tuple `{:ok, bin}` where bin is defined as the parameter string,
  the values passed in order, and a carraige return (\r)

  ## Examples
      iex> QscanT.Commands.encode("X092", ["y"])
      {:ok, "X092y\r"}


  """
  @doc since: "0.1.0"
  def encode(parameter, values) do
    encoded_values =
      for element <- values do
        <<element>>
      end

    encoded_command = [parameter] ++ encoded_values
    bin = Enum.join(encoded_command)
    {:ok, <<bin::binary, "\r">>}
  end

  @doc """
  Set control card mode. If set true, control cards cannot be scanned to program
  the device. When locked, can only be controlled via serial data channel
  """
  @doc since: "0.1.0"
  def control_card_lockout(locked?) do
    parameter = "X039"

    values =
      if locked? === true do
        [49]
      else
        [48]
      end

    encode(parameter, values)
  end

  @doc """
  Restarts the QScan Device
  """
  @doc since: "0.1.0"
  def restart() do
    parameter = "X0721"
    values = []
    encode(parameter, values)
  end

  @doc """
  Command to return the firmware identification string
  """
  @doc since: "0.1.0"
  def version() do
    parameter = "V"
    values = []
    encode(parameter, values)
  end
end
