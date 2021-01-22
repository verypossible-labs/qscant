defmodule QscanT do
  @moduledoc """
  QscanT Driver based on qscan203 manual. Revision Date Feb 26, 2019
  """
  alias QscanT.Commands

  defdelegate encode_command(parameter, values), to: Commands, as: :encode
end
