namespace :draw do
  desc "Uses an image binary to draw a number"

  task draw_number: :environment do
  end

  task draw_nine: :environment do
    response = call_binary(draw_nine_body(320))
    write_file(response)
  end

  task draw_eight: :environment do
    response = call_binary(draw_eight_body(320))
    write_file(response)
  end

  task draw_seven: :environment do
    response = call_binary(draw_seven_body(320))
    write_file(response)
  end

  task draw_six: :environment do
    response = call_binary(draw_six_body(320))
    write_file(response)
  end

  task draw_five: :environment do
    response = call_binary(draw_five_body(320))
    write_file(response)
  end

  task draw_four: :environment do
    response = call_binary(draw_four_body(320))
    write_file(response)
  end

  task draw_three: :environment do
    response = call_binary(draw_three_body(320))
    write_file(response)
  end

  task draw_two: :environment do
    response = call_binary(draw_two_body(320))
    write_file(response)
  end

  task draw_one: :environment do
    response = call_binary(draw_one_body(320))
    write_file(response)
  end

  task draw_zero: :environment do
    response = call_binary(draw_zero_body(320))
    write_file(response)
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

  digit_index_to_starting_x_coordinate = {
    0 => 20, # thousands
    1 => 120, # hundreds
    2 => 220, # tens
    3 => 320 # ones
  }

  def draw_nine_body starting_x
    ending_x = starting_x + 60
    body = "{'canvas_width': 500, 'canvas_height': 200, 'img_commands': [
    {'cmd': 'SetRGBA', 'args': [1,1,0,1]},
    {'cmd': 'SetLineWidth', 'args': [6]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{ending_x}, 100]},
    {'cmd': 'Stroke'}
    ]}"
    body.gsub!("'", '"')
  end

  def draw_eight_body starting_x
    ending_x = starting_x + 60
    body = "{'canvas_width': 500, 'canvas_height': 200, 'img_commands': [
    {'cmd': 'SetRGBA', 'args': [1,1,0,1]},
    {'cmd': 'SetLineWidth', 'args': [6]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{ending_x}, 100]},
    {'cmd': 'Stroke'}
    ]}"
    body.gsub!("'", '"')
  end

  def draw_seven_body starting_x
    ending_x = starting_x + 60
    body = "{'canvas_width': 500, 'canvas_height': 200, 'img_commands': [
    {'cmd': 'SetRGBA', 'args': [1,1,0,1]},
    {'cmd': 'SetLineWidth', 'args': [6]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'Stroke'}
    ]}"
    body.gsub!("'", '"')
  end

  def draw_six_body starting_x
    ending_x = starting_x + 60
    body = "{'canvas_width': 500, 'canvas_height': 200, 'img_commands': [
    {'cmd': 'SetRGBA', 'args': [1,1,0,1]},
    {'cmd': 'SetLineWidth', 'args': [6]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{ending_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 180, #{starting_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{starting_x}, 180]},
    {'cmd': 'Stroke'}
    ]}"
    body.gsub!("'", '"')
  end

  def draw_five_body starting_x
    ending_x = starting_x + 60
    body = "{'canvas_width': 500, 'canvas_height': 200, 'img_commands': [
    {'cmd': 'SetRGBA', 'args': [1,1,0,1]},
    {'cmd': 'SetLineWidth', 'args': [6]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{ending_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 180, #{starting_x}, 180]},
    {'cmd': 'Stroke'}
    ]}"
    body.gsub!("'", '"')
  end

  def draw_four_body starting_x
    ending_x = starting_x + 60
    body = "{'canvas_width': 500, 'canvas_height': 200, 'img_commands': [
    {'cmd': 'SetRGBA', 'args': [1,1,0,1]},
    {'cmd': 'SetLineWidth', 'args': [6]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{ending_x}, 180]},
    {'cmd': 'Stroke'}
    ]}"
    body.gsub!("'", '"')
  end

  def draw_three_body starting_x
    ending_x = starting_x + 60
    body = "{'canvas_width': 500, 'canvas_height': 200, 'img_commands': [
    {'cmd': 'SetRGBA', 'args': [1,1,0,1]},
    {'cmd': 'SetLineWidth', 'args': [6]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},
    {'cmd': 'Stroke'}
    ]}"
    body.gsub!("'", '"')
  end

  def draw_two_body starting_x
    ending_x = starting_x + 60
    body = "{'canvas_width': 500, 'canvas_height': 200, 'img_commands': [
    {'cmd': 'SetRGBA', 'args': [1,1,0,1]},
    {'cmd': 'SetLineWidth', 'args': [6]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 100, #{starting_x}, 100]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 100, #{starting_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},
    {'cmd': 'Stroke'}
    ]}"
    body.gsub!("'", '"')
  end

  def draw_one_body starting_x
    ending_x = starting_x + 60
    body = "{'canvas_width': 500, 'canvas_height': 200, 'img_commands': [
    {'cmd': 'SetRGBA', 'args': [207, 0, 15, 1]},
    {'cmd': 'SetLineWidth', 'args': [6]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 180]},
    {'cmd': 'Stroke'}
    ]}"
    body.gsub!("'", '"')
  end

  def draw_zero_body starting_x
    ending_x = starting_x + 60
    body = "{'canvas_width': 500, 'canvas_height': 200, 'img_commands': [
    {'cmd': 'SetRGBA', 'args': [207, 0, 15, 1]},
    {'cmd': 'SetLineWidth', 'args': [6]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{starting_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{ending_x}, 20, #{ending_x}, 180]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 20, #{ending_x}, 20]},
    {'cmd': 'DrawLine', 'args':[#{starting_x}, 180, #{ending_x}, 180]},
    {'cmd': 'Stroke'}
    ]}"
    body.gsub!("'", '"')
  end
end
