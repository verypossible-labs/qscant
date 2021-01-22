defmodule QscanT.PeripheralsTest do
  use ExUnit.Case, async: true
  alias QscanT.Peripherals

  describe "bicolor_led_blink_off/1" do
    test "valid time" do
      parameter = "("
      time = 20

      ascii_time = Integer.to_string(time)
      expected_command = parameter <> ascii_time <> "\r"

      assert {:ok, actual_command} = Peripherals.bicolor_led_blink_off(time)
      assert expected_command == actual_command
    end

    test "invalid time" do
      time = 100
      assert {:error, :out_of_bounds} = Peripherals.bicolor_led_blink_off(time)
    end
  end

  describe "bicolor_led_blink_on/1" do
    test "valid time" do
      parameter = ")"
      time = 20

      ascii_time = Integer.to_string(time)
      expected_command = parameter <> ascii_time <> "\r"

      assert {:ok, actual_command} = Peripherals.bicolor_led_blink_on(time)
      assert expected_command == actual_command
    end

    test "invalid time" do
      time = 100
      assert {:error, :out_of_bounds} = Peripherals.bicolor_led_blink_on(time)
    end
  end

  describe "bicolor_led_flash_off/1" do
    test "valid time" do
      parameter = "{"
      time = 20

      ascii_time = Integer.to_string(time)
      expected_command = parameter <> ascii_time <> "\r"

      assert {:ok, actual_command} = Peripherals.bicolor_led_flash_off(time)
      assert expected_command == actual_command
    end

    test "invalid time" do
      time = 100
      assert {:error, :out_of_bounds} = Peripherals.bicolor_led_flash_off(time)
    end
  end

  describe "bicolor_led_mode/1" do
    test "valid mode" do
      parameter = "X031"
      led_mode = :off_red
      expected_command = parameter <> "1" <> "\r"

      assert {:ok, actual_command} = Peripherals.bicolor_led_mode(led_mode)
      assert expected_command == actual_command
    end

    test "invalid mode" do
      led_mode = :invalid
      assert {:error, :invalid_mode} = Peripherals.bicolor_led_mode(led_mode)
    end
  end

  describe "green_led_blink_off/1" do
    test "valid time" do
      parameter = "<"
      time = 20

      ascii_time = Integer.to_string(time)
      expected_command = parameter <> ascii_time <> "\r"

      assert {:ok, actual_command} = Peripherals.green_led_blink_off(time)
      assert expected_command == actual_command
    end

    test "invalid time" do
      time = 100
      assert {:error, :out_of_bounds} = Peripherals.green_led_blink_off(time)
    end
  end

  describe "green_led_blink_on/1" do
    test "valid time" do
      parameter = ">"
      time = 20

      ascii_time = Integer.to_string(time)
      expected_command = parameter <> ascii_time <> "\r"

      assert {:ok, actual_command} = Peripherals.green_led_blink_on(time)
      assert expected_command == actual_command
    end

    test "invalid time" do
      time = 100
      assert {:error, :out_of_bounds} = Peripherals.green_led_blink_on(time)
    end
  end

  describe "green_led_flash_off/1" do
    test "valid time" do
      parameter = "["
      time = 20

      ascii_time = Integer.to_string(time)
      expected_command = parameter <> ascii_time <> "\r"

      assert {:ok, actual_command} = Peripherals.green_led_flash_off(time)
      assert expected_command == actual_command
    end

    test "invalid time" do
      time = 100
      assert {:error, :out_of_bounds} = Peripherals.green_led_flash_off(time)
    end
  end

  describe "green_led_flash_on/1" do
    test "valid time" do
      parameter = "]"
      time = 20

      ascii_time = Integer.to_string(time)
      expected_command = parameter <> ascii_time <> "\r"

      assert {:ok, actual_command} = Peripherals.green_led_flash_on(time)
      assert expected_command == actual_command
    end

    test "invalid time" do
      time = 100
      assert {:error, :out_of_bounds} = Peripherals.green_led_flash_on(time)
    end
  end

  test "poll_digital_1/0" do
    parameter = "%"
    expected_command = parameter <> "\r"
    assert {:ok, actual_command} = Peripherals.poll_digital_1()
    assert expected_command == actual_command
  end

  test "poll_digital_2/0" do
    parameter = "$"
    expected_command = parameter <> "\r"
    assert {:ok, actual_command} = Peripherals.poll_digital_2()
    assert expected_command == actual_command
  end

  test "relay_off/0" do
    parameter = "*"
    expected_command = parameter <> "\r"
    assert {:ok, actual_command} = Peripherals.relay_off()
    assert expected_command == actual_command
  end

  describe "relay_on/1" do
    test "valid time" do
      parameter = "!"
      time = 20

      ascii_time = Integer.to_string(time)
      expected_command = parameter <> ascii_time <> "\r"
      assert {:ok, actual_command} = Peripherals.relay_on(time)
      assert expected_command == actual_command
    end

    test "invalid time" do
      time = 100
      assert {:error, :out_of_bounds} = Peripherals.relay_on(time)
    end
  end

  describe "set_digital_event_mask/4" do
    test "all true" do
      parameter = "X078"
      d1 = true
      d2 = true
      d3 = true
      d4 = true
      expected_command = parameter <> "1111" <> "\r"

      assert {:ok, actual_command} = Peripherals.set_digital_event_mask(d1, d2, d3, d4)
      assert expected_command == actual_command
    end

    test "all false" do
      parameter = "X078"
      d1 = false
      d2 = false
      d3 = false
      d4 = false
      expected_command = parameter <> "0000" <> "\r"

      assert {:ok, actual_command} = Peripherals.set_digital_event_mask(d1, d2, d3, d4)
      assert expected_command == actual_command
    end

    test "first true, rest false" do
      parameter = "X078"
      d1 = true
      d2 = false
      d3 = false
      d4 = false
      expected_command = parameter <> "1000" <> "\r"

      assert {:ok, actual_command} = Peripherals.set_digital_event_mask(d1, d2, d3, d4)
      assert expected_command == actual_command
    end
  end

  describe "speaker_on/1" do
    test "valid time" do
      parameter = "&"
      time = 20
      ascii_time = Integer.to_string(time)
      expected_command = parameter <> ascii_time <> "\r"

      assert {:ok, actual_command} = Peripherals.speaker_on(time)
      assert expected_command == actual_command
    end

    test "invaid time" do
      time = 100
      assert {:error, :out_of_bounds} = Peripherals.speaker_on(time)
    end
  end

  describe "speaker_setup/5" do
    test "valid configuration" do
      parameter = "X077"
      startup_beep = true
      frequency = 4400
      duty_on = 3
      duty_off = 4
      good_read_beep_time = 5

      expected_command = parameter <> "1" <> "4400" <> "3" <> "4" <> "05" <> "\r"

      assert {:ok, actual_command} =
               Peripherals.speaker_setup(
                 startup_beep,
                 frequency,
                 duty_on,
                 duty_off,
                 good_read_beep_time
               )

      assert expected_command == actual_command
    end
  end
end
