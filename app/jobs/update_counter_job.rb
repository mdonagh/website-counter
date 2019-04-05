class UpdateCounterJob < ActiveJob::Base
  queue_as :my_jobs

  def perform()
    number = Impression.count
    return if multiple_draw_jobs_queued
    number = add_zeros(number)
    draw_commands = process_draw_commands(number)
    response = call_binary(draw_commands)
    write_file(response)
  end

  def process_draw_commands number
    draw_commands = draw_canvas_body
    draw_commands.concat(number
                          .split('')
                          .each_with_index.map { |digit, digit_index| draw_commands_for_digit(digit, digit_index) }
                          .join('')
                        )
    finish_draw_commands(draw_commands)
  end

  def multiple_draw_jobs_queued
    if Delayed::Job.count > 1 
      Delayed::Job.where.not(id: Delayed::Job.last.id).destroy_all
      return true
    end
    false
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
    if number.length > 4
      return "9999"
    end

    while(number.length < 4)
      number.prepend("0")
    end
    number
  end

  def finish_draw_commands draw_commands
    draw_commands.concat('{"cmd": "Stroke"}]}"')
  end

  def draw_commands_for_digit digit, digit_index
    digit = digit.to_i
    starting_x = index_to_starting_x_coordinate(digit_index)

    case digit
      when 0
        draw_commands = draw_zero_body(starting_x)
      when 1
        draw_commands = draw_one_body(starting_x)
      when 2
        draw_commands = draw_two_body(starting_x)
      when 3
        draw_commands = draw_three_body(starting_x)
      when 4
        draw_commands = draw_four_body(starting_x)
      when 5
        draw_commands = draw_five_body(starting_x)
      when 6
        draw_commands = draw_six_body(starting_x)
      when 7
        draw_commands = draw_seven_body(starting_x)
      when 8
        draw_commands = draw_eight_body(starting_x)
      when 9
        draw_commands = draw_nine_body(starting_x)
      else
        puts "Error: invalid digit: (#{digit})"
      end
      draw_commands.gsub!("'", '"')
    end

  def write_file response
    File.open(Rails.root.join('public', 'counter', 'new_image.png'), 'wb') { |fp| fp.write(response.body) }
    File.delete(Rails.root.join('public', 'counter', 'image.png')) if File.exist?(Rails.root.join('public', 'image.png'))
    File.rename(Rails.root.join('public', 'counter', 'new_image.png'), Rails.root.join('public', 'counter', 'image.png'))
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
    return "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{ending_x}, 100]},"
  end

  def draw_eight_body starting_x
    ending_x = starting_x + 60
    return "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{ending_x}, 100]},"
  end

  def draw_seven_body starting_x
    ending_x = starting_x + 60
    return "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'Stroke'}"
  end

  def draw_six_body starting_x
    ending_x = starting_x + 60
    return "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{ending_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 180, #{starting_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{starting_x}, 180]},"
  end

  def draw_five_body starting_x
    ending_x = starting_x + 60
    return "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{ending_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 180, #{starting_x}, 180]},"
  end

  def draw_four_body starting_x
    ending_x = starting_x + 60
    return "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{ending_x}, 180]},"
  end

  def draw_three_body starting_x
    ending_x = starting_x + 60
    return "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},"
  end

  def draw_two_body starting_x
    ending_x = starting_x + 60
    return "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{starting_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},"
  end

  def draw_one_body starting_x
    ending_x = starting_x + 60
    return "{'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},"
  end

  def draw_zero_body starting_x
    ending_x = starting_x + 60
    return "{'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},"
  end
end