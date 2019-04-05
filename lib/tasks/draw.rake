namespace :draw do
  desc "Uses an image binary to draw a number"

  task draw_number: :environment do
    number = 1134
    number = add_zeros(number)
    if number.length > 4
      number = "9999"
    end
    draw_commands = draw_canvas_body
    number.each_char.with_index do |digit, digit_index|
      draw_commands.concat(draw_commands_for_digit(digit, digit_index))
    end
    draw_commands = finish_draw_commands(draw_commands)
    response = call_binary(draw_commands)
    write_file(response)
  end

  def index_to_starting_x_coordinate digit
    case digit
      when 0
        return 20
      when 1
        return 120
      when 2
        return 220
      when 3
        return 320
      else
        puts "Error: invalid digit: (#{digit})"
      end
    end

  def add_zeros number
    number = number.to_s
    while(number.length < 4)
      number.prepend("0")
    end
    return number
  end

  def finish_draw_commands draw_commands
    draw_commands.concat('{"cmd": "Stroke"}]}"')
  end

  def draw_commands_for_digit digit, digit_index
    digit = digit.to_i
    starting_x = index_to_starting_x_coordinate(digit_index)

    case digit
      when 0
        return draw_zero_body(starting_x)
      when 1
        return draw_one_body(starting_x)
      when 2
        return draw_two_body(starting_x)
      when 3
        return draw_three_body(starting_x)
      when 4
        return draw_four_body(starting_x)
      when 5
        return draw_five_body(starting_x)
      when 6
        return draw_six_body(starting_x)
      when 7
        return draw_seven_body(starting_x)
      when 8
        return draw_eight_body(starting_x)
      when 9
        return draw_nine_body(starting_x)
      else
        puts "Error: invalid digit: (#{digit})"
      end
    end

  def write_file response
    File.delete(Rails.root.join('public', 'image.png')) if File.exist?(Rails.root.join('public', 'image.png'))
    File.open(Rails.root.join('public', 'image.png'), 'wb') { |fp| fp.write(response.body) }
  end

  def call_binary draw_body
    conn = Faraday.new(:url => 'http://localhost:8088')
    response = conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = draw_body
    end
    response
  end

  def draw_canvas_body
    '{"canvas_width": 500, "canvas_height": 200, "img_commands": [
    {"cmd": "SetRGBA", "args": [1,1,0,1]},
    {"cmd": "SetLineWidth", "args": [6]},'
  end

  def draw_nine_body starting_x
    ending_x = starting_x + 60
    body = "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{ending_x}, 100]},"
    body.gsub!("'", '"')
  end

  def draw_eight_body starting_x
    ending_x = starting_x + 60
    body = "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{ending_x}, 100]},"
    body.gsub!("'", '"')
  end

  def draw_seven_body starting_x
    ending_x = starting_x + 60
    body = "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'Stroke'}"
    body.gsub!("'", '"')
  end

  def draw_six_body starting_x
    ending_x = starting_x + 60
    body = "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{ending_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 180, #{starting_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{starting_x}, 180]},"
    body.gsub!("'", '"')
  end

  def draw_five_body starting_x
    ending_x = starting_x + 60
    body = "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{ending_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 180, #{starting_x}, 180]},"
    body.gsub!("'", '"')
  end

  def draw_four_body starting_x
    ending_x = starting_x + 60
    body = "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{ending_x}, 180]},"
    body.gsub!("'", '"')
  end

  def draw_three_body starting_x
    ending_x = starting_x + 60
    body = "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},"
    body.gsub!("'", '"')
  end

  def draw_two_body starting_x
    ending_x = starting_x + 60
    body = "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{starting_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},"
    body.gsub!("'", '"')
  end

  def draw_one_body starting_x
    ending_x = starting_x + 60
    body = "{'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},"
    body.gsub!("'", '"')
  end

  def draw_zero_body starting_x
    ending_x = starting_x + 60
    body = "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},"
    body.gsub!("'", '"')
  end
end
