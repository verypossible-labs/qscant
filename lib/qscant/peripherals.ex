defmodule QscanT.Peripherals do
  @moduledoc """
    Qscan Peripheral Commands. Verbage from the qscan203.pdf reference.
    Reference revision date February 26, 2019
  """
  alias QscanT.Commands

  @doc """
  Blinks the bicolor led for `time` seconds, then leaves it in the "off" state
  """
  @doc since: "0.1.0"
  def bicolor_led_blink_off(time)
      when time < 100 do
    parameter = "("
    char_time = String.to_charlist(String.pad_leading(Integer.to_string(time), 2, "0"))
    Commands.encode(parameter, char_time)
  end

  def bicolor_led_blink_off(_time) do
    {:error, :out_of_bounds}
  end

  @doc """
  Blinks the bicolor led for `time` seconds, then leaves it in the "on" state
  """
  @doc since: "0.1.0"
  def bicolor_led_blink_on(time)
      when time < 100 do
    parameter = ")"
    char_time = String.to_charlist(String.pad_leading(Integer.to_string(time), 2, "0"))
    Commands.encode(parameter, char_time)
  end

  def bicolor_led_blink_on(_time) do
    {:error, :out_of_bounds}
  end

  @doc """
  Turns the bicolor led off for `time` seconds, then leaves it in the "on" state
  """
  @doc since: "0.1.0"
  def bicolor_led_flash_off(time)
      when time < 100 do
    parameter = "{"
    char_time = String.to_charlist(String.pad_leading(Integer.to_string(time), 2, "0"))
    Commands.encode(parameter, char_time)
  end

  def bicolor_led_flash_off(_time) do
    {:error, :out_of_bounds}
  end

  @doc """
  Turns the bicolor led on for `time` seconds, then leaves it in the "off" state
  """
  @doc since: "0.1.0"
  def bicolor_led_flash_on(time)
      when time < 100 do
    parameter = "}"
    char_time = String.to_charlist(String.pad_leading(Integer.to_string(time), 2, "0"))
    Commands.encode(parameter, char_time)
  end

  def bicolor_led_flash_on(_time) do
    {:error, :out_of_bounds}
  end

  @doc """
  Sets the bicolor led's mode between it's three options:
  "off" | "on"
  ------+-------
  red   | green
  off   | red
  off   | green
  """
  @doc since: "0.1.0"
  def bicolor_led_mode(led_mode) do
    parameter = "X031"

    mode =
      case led_mode do
        :red_green -> '0'
        :off_red -> '1'
        :off_green -> '2'
        _ -> :error
      end

    if mode == :error do
      {:error, :invalid_mode}
    else
      Commands.encode(parameter, mode)
    end
  end

  @doc """
  Blinks thee green led for `time` seconds, then leaves it off
  """
  @doc since: "0.1.0"
  def green_led_blink_off(time)
      when time < 100 do
    parameter = "<"
    char_time = String.to_charlist(String.pad_leading(Integer.to_string(time), 2, "0"))
    Commands.encode(parameter, char_time)
  end

  def green_led_blink_off(_time) do
    {:error, :out_of_bounds}
  end

  @doc """
  Blinks the green led for `time` seconds, then leaves it on
  """
  @doc since: "0.1.0"
  def green_led_blink_on(time)
      when time < 100 do
    parameter = ">"
    char_time = String.to_charlist(String.pad_leading(Integer.to_string(time), 2, "0"))
    Commands.encode(parameter, char_time)
  end

  def green_led_blink_on(_time) do
    {:error, :out_of_bounds}
  end

  @doc """
  Turns the green led off for `time` seconds, then leaves it off
  """
  @doc since: "0.1.0"
  def green_led_flash_off(time)
      when time < 100 do
    parameter = "["
    char_time = String.to_charlist(String.pad_leading(Integer.to_string(time), 2, "0"))
    Commands.encode(parameter, char_time)
  end

  def green_led_flash_off(_time) do
    {:error, :out_of_bounds}
  end

  @doc """
  Turns the green led on for `time` seconds, then leaves it off
  """
  @doc since: "0.1.0"
  def green_led_flash_on(time)
      when time < 100 do
    parameter = "]"
    char_time = String.to_charlist(String.pad_leading(Integer.to_string(time), 2, "0"))
    Commands.encode(parameter, char_time)
  end

  def green_led_flash_on(_time) do
    {:error, :out_of_bounds}
  end

  @doc """
  Poll digital input 1, device will respond with "ON" or "OFF"
  """
  @doc since: "0.1.0"
  def poll_digital_1() do
    parameter = "%"
    Commands.encode(parameter, [])
  end

  @doc """
  Poll digital input 2, device will respond with "ON" or "OFF"
  """
  @doc since: "0.1.0"
  def poll_digital_2() do
    parameter = "$"
    Commands.encode(parameter, [])
  end

  @doc """
  Turn the relay off
  """
  @doc since: "0.1.0"
  def relay_off() do
    parameter = "*"
    Commands.encode(parameter, [])
  end

  @doc """
  Turn the relay on for `time` seconds (up to 99)
  """
  @doc since: "0.1.0"
  def relay_on(time)
      when time < 100 do
    parameter = "!"
    value = String.to_charlist(String.pad_leading(Integer.to_string(time), 2, "0"))
    Commands.encode(parameter, value)
  end

  def relay_on(_time) do
    {:error, :out_of_bounds}
  end

  @doc """
  Configure automatic sense events on digital inputs.
  Device is capable of both rising and falling edge sensing.
  There is a 3/10ths a second delay between event and sense trigger.
  This function generates the masking command for these events
  """
  def set_digital_event_mask(
        digital_1_rising?,
        digital_1_falling?,
        digital_2_rising?,
        digital_2_falling?
      ) do
    parameter = "X078"

    value1 =
      if digital_1_rising? === true do
        '1'
      else
        '0'
      end

    value2 =
      if digital_1_falling? === true do
        '1'
      else
        '0'
      end

    value3 =
      if digital_2_rising? === true do
        '1'
      else
        '0'
      end

    value4 =
      if digital_2_falling? === true do
        '1'
      else
        '0'
      end

    values = value1 ++ value2 ++ value3 ++ value4
    Commands.encode(parameter, values)
  end

  @doc """
  Turn the speaker on for `time` * 10ms duration
  Actual speaker frequency / duty cycle is defined in speaker_setup
  """
  @doc since: "0.1.0"
  def speaker_on(time)
      when time < 100 do
    parameter = "&"
    value = String.to_charlist(String.pad_leading(Integer.to_string(time), 2, "0"))
    Commands.encode(parameter, value)
  end

  def speaker_on(_time) do
    {:error, :out_of_bounds}
  end

  @doc """
  Setup the speaker for output
  good_read_beep_time is expressed in intervals of 40ms
  """
  @doc since: "0.1.0"
  def speaker_setup(startup_beep?, frequency, duty_on, duty_off, good_read_beep_time)
      when frequency < 10000 and duty_on < 10 and duty_off < 10 and good_read_beep_time < 100 do
    parameter = "X077"

    value1 =
      if startup_beep? === true do
        '1'
      else
        '0'
      end

    value2 = String.to_charlist(String.pad_leading(Integer.to_string(frequency), 4, "0"))

    value3 = Integer.to_charlist(duty_on)
    value4 = Integer.to_charlist(duty_off)

    value5 =
      String.to_charlist(String.pad_leading(Integer.to_string(good_read_beep_time), 2, "0"))

    values = value1 ++ value2 ++ value3 ++ value4 ++ value5
    Commands.encode(parameter, values)
  end

  def speaker_setup(_startup_beep, _frequency, _duty_on, _duty_off, _good_read_beep_time) do
    {:error, :out_of_bounds}
  end
end
