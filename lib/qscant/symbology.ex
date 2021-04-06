defmodule QscanT.Symbology do
  @moduledoc """
    Qscan symbology commands. Verbage and reference from the qscan203 reference
    Reference revision date February 26, 2019
  """

  alias QscanT.Commands

  @doc """
  Generates a string of 7 symbology setup commands to cover all symbologies.
  This will enable only symbologies defined in the input map symbols, and will
  deactivate all other symbologies from the reader

  Returns tuple `{:ok, bin}` where bin is defined as the resultant commands

  ## Examples
      iex> QscanT.Symbology.symbology_setup(%{code_39: true, qr: true})
      {:ok,
      "X00110000000\rX00200000000\rX00300000000\rX00400000000\rX00500000000\rX00600010000\rX00700000000\r"}

  """
  @doc since: "0.1.0"
  def symbology_setup(symbols) do
    {:ok, bin1} = symbology_setup1(symbols)
    {:ok, bin2} = symbology_setup2(symbols)
    {:ok, bin3} = symbology_setup3(symbols)
    {:ok, bin4} = symbology_setup4(symbols)
    {:ok, bin5} = symbology_setup5(symbols)
    {:ok, bin6} = symbology_setup6(symbols)
    {:ok, bin7} = symbology_setup7(symbols)

    {:ok,
     <<bin1::binary, bin2::binary, bin3::binary, bin4::binary, bin5::binary, bin6::binary,
       bin7::binary>>}
  end

  def symbology_setup1(symbols) do
    # :ean8 enables both ean8 and jan8 as they are the same toggle
    supported_symbols = [
      :code_39,
      :code_39_full_ascii,
      :code_39_trioptic,
      :code_39_to_code_32,
      :code_39_check_digit,
      :upc_a,
      :upc_e,
      :ean8
    ]

    parameter = "X001"

    {:ok, values} = encode_symbols(supported_symbols, symbols)

    Commands.encode(parameter, values)
  end

  def symbology_setup2(symbols) do
    supported_symbols = [
      :ean13,
      :code_128,
      :gs1,
      :ibst_128,
      :code_93,
      :code_11,
      :code_11_check_digit,
      :interleaved_2_of_5
    ]

    parameter = "X002"

    {:ok, values} = encode_symbols(supported_symbols, symbols)

    Commands.encode(parameter, values)
  end

  # 2 of 5 has been renamed two_of_5 for atomization
  def symbology_setup3(symbols) do
    supported_symbols = [
      :i_2_of_5_check_digit,
      :two_of_5,
      :codabar,
      :codabar_clsi,
      :msi_plessy,
      :chinese_2_of_5,
      :matrix_2_of_5,
      :m_2_of_5_check_digit
    ]

    parameter = "X003"

    {:ok, values} = encode_symbols(supported_symbols, symbols)

    Commands.encode(parameter, values)
  end

  def symbology_setup4(symbols) do
    supported_symbols = [
      :korean_3_of_5,
      :postnet,
      :planet,
      :postal,
      :japan_post,
      :australia_post,
      :kix,
      :usps_onecode
    ]

    parameter = "X004"

    {:ok, values} = encode_symbols(supported_symbols, symbols)

    Commands.encode(parameter, values)
  end

  def symbology_setup5(symbols) do
    supported_symbols = [
      :upu_fics,
      :gs1_14i,
      :composite_cc,
      :composite_ccab,
      :composite_tlc39,
      :pdf417,
      :micropdf,
      :datamatrix
    ]

    parameter = "X005"

    {:ok, values} = encode_symbols(supported_symbols, symbols)

    Commands.encode(parameter, values)
  end

  def symbology_setup6(symbols) do
    supported_symbols = [
      :datamatrix_inverse,
      :unused1,
      :maxicode,
      :qr,
      :qr_inverse,
      :micro_qr,
      :aztec,
      :aztec_inverse
    ]

    parameter = "X006"

    {:ok, values} = encode_symbols(supported_symbols, symbols)

    Commands.encode(parameter, values)
  end

  def symbology_setup7(symbols) do
    supported_symbols = [
      :bookland,
      :postbar,
      :macro_pdf,
      :uuc_coupon,
      :unused2,
      :unused3,
      :unused4,
      :unused5
    ]

    parameter = "X007"

    {:ok, values} = encode_symbols(supported_symbols, symbols)

    Commands.encode(parameter, values)
  end

  defp encode_symbols(supported, actual) do
    values =
      for symbol <- supported do
        {:ok, value} = symbol_check(actual, symbol)
        value
      end

    {:ok, values}
  end

  # returns ascii 0 if symbol doesn't exist in the map
  # returns ascii 1 for true,
  # returns ascii 0 for false
  defp symbol_check(map, symbol) do
    symbol_value =
      if Map.has_key?(map, symbol) do
        {:ok, value} = Map.fetch(map, symbol)

        if value === true do
          # Ascii for "1"
          49
        else
          # Ascii for "0"
          48
        end
      else
        48
      end

    {:ok, symbol_value}
  end
end
