namespace :draw do
  desc "TODO"

  task draw_nine: :environment do
    response = call_binary(draw_nine_body)
    write_file(response)
  end


  task draw_eight: :environment do
    response = call_binary(draw_eight_body)
    write_file(response)
  end

  task draw_seven: :environment do
    response = call_binary(draw_seven_body)
    write_file(response)
  end

  task draw_six: :environment do
    response = call_binary(draw_six_body)
    write_file(response)
  end

  task draw_five: :environment do
    response = call_binary(draw_five_body)
    write_file(response)
  end

  task draw_four: :environment do
    response = call_binary(draw_four_body)
    write_file(response)
  end

  task draw_three: :environment do
    response = call_binary(draw_three_body)
    write_file(response)
  end

  task draw_two: :environment do
    response = call_binary(draw_two_body)
    write_file(response)
  end

  task draw_one: :environment do
    response = call_binary(draw_one_body)
    write_file(response)
  end

  task draw_zero: :environment do
    response = call_binary(draw_zero_body)
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

  def draw_nine_body
    '{"canvas_width": 500, "canvas_height": 200, "img_commands": [
    {"cmd": "SetRGBA", "args": [1,1,0,1]},
    {"cmd": "SetLineWidth", "args": [6]},
    {"cmd": "DrawLine", "args":[20, 20, 80, 20]},
    {"cmd": "DrawLine", "args":[20, 20, 20, 100]},
    {"cmd": "DrawLine", "args":[80, 20, 80, 180]},
    {"cmd": "DrawLine", "args":[20, 180, 80, 180]},
    {"cmd": "DrawLine", "args":[20, 100, 80, 100]},
    {"cmd": "Stroke"}
    ]}'
  end

  def draw_eight_body
    '{"canvas_width": 500, "canvas_height": 200, "img_commands": [
    {"cmd": "SetRGBA", "args": [1,1,0,1]},
    {"cmd": "SetLineWidth", "args": [6]},
    {"cmd": "DrawLine", "args":[20, 20, 80, 20]},
    {"cmd": "DrawLine", "args":[20, 20, 20, 180]},
    {"cmd": "DrawLine", "args":[80, 20, 80, 180]},
    {"cmd": "DrawLine", "args":[20, 180, 80, 180]},
    {"cmd": "DrawLine", "args":[20, 100, 80, 100]},
    {"cmd": "Stroke"}
    ]}'
  end

  def draw_seven_body
    '{"canvas_width": 500, "canvas_height": 200, "img_commands": [
    {"cmd": "SetRGBA", "args": [1,1,0,1]},
    {"cmd": "SetLineWidth", "args": [6]},
    {"cmd": "DrawLine", "args":[20, 20, 80, 20]},
    {"cmd": "DrawLine", "args":[80, 20, 80, 180]},
    {"cmd": "Stroke"}
    ]}'
  end

  def draw_six_body
    '{"canvas_width": 500, "canvas_height": 200, "img_commands": [
    {"cmd": "SetRGBA", "args": [1,1,0,1]},
    {"cmd": "SetLineWidth", "args": [6]},
    {"cmd": "DrawLine", "args":[20, 20, 80, 20]},
    {"cmd": "DrawLine", "args":[20, 20, 20, 100]},
    {"cmd": "DrawLine", "args":[20, 100, 80, 100]},
    {"cmd": "DrawLine", "args":[80, 100, 80, 180]},
    {"cmd": "DrawLine", "args":[80, 180, 20, 180]},
    {"cmd": "DrawLine", "args":[20, 100, 20, 180]},
    {"cmd": "Stroke"}
    ]}'
  end

  def draw_five_body
    '{"canvas_width": 500, "canvas_height": 200, "img_commands": [
    {"cmd": "SetRGBA", "args": [1,1,0,1]},
    {"cmd": "SetLineWidth", "args": [6]},
    {"cmd": "DrawLine", "args":[20, 20, 20, 100]},
    {"cmd": "DrawLine", "args":[20, 20, 80, 20]},
    {"cmd": "DrawLine", "args":[20, 100, 80, 100]},
    {"cmd": "DrawLine", "args":[80, 100, 80, 180]},
    {"cmd": "DrawLine", "args":[80, 180, 20, 180]},
    {"cmd": "Stroke"}
    ]}'
  end

  def draw_four_body
    '{"canvas_width": 500, "canvas_height": 200, "img_commands": [
    {"cmd": "SetRGBA", "args": [1,1,0,1]},
    {"cmd": "SetLineWidth", "args": [6]},
    {"cmd": "DrawLine", "args":[20, 20, 20, 100]},
    {"cmd": "DrawLine", "args":[80, 20, 80, 180]},
    {"cmd": "DrawLine", "args":[80, 100, 20, 100]},
    {"cmd": "DrawLine", "args":[80, 100, 80, 180]},
    {"cmd": "Stroke"}
    ]}'
  end

  def draw_three_body
    '{"canvas_width": 500, "canvas_height": 200, "img_commands": [
    {"cmd": "SetRGBA", "args": [1,1,0,1]},
    {"cmd": "SetLineWidth", "args": [6]},
    {"cmd": "DrawLine", "args":[20, 20, 80, 20]},
    {"cmd": "DrawLine", "args":[80, 20, 80, 180]},
    {"cmd": "DrawLine", "args":[80, 100, 20, 100]},
    {"cmd": "DrawLine", "args":[20, 180, 80, 180]},
    {"cmd": "Stroke"}
    ]}'
  end

  def draw_two_body
    '{"canvas_width": 500, "canvas_height": 200, "img_commands": [
    {"cmd": "SetRGBA", "args": [1,1,0,1]},
    {"cmd": "SetLineWidth", "args": [6]},
    {"cmd": "DrawLine", "args":[20, 20, 80, 20]},
    {"cmd": "DrawLine", "args":[80, 20, 80, 100]},
    {"cmd": "DrawLine", "args":[80, 100, 20, 100]},
    {"cmd": "DrawLine", "args":[20, 100, 20, 180]},
    {"cmd": "DrawLine", "args":[20, 180, 80, 180]},
    {"cmd": "Stroke"}
    ]}'
  end

  def draw_zero_body
    '{"canvas_width": 500, "canvas_height": 200, "img_commands": [
    {"cmd": "SetRGBA", "args": [207, 0, 15, 1]},
    {"cmd": "SetLineWidth", "args": [6]},
    {"cmd": "DrawLine", "args":[20, 20, 20, 180]},
    {"cmd": "DrawLine", "args":[80, 20, 80, 180]},
    {"cmd": "DrawLine", "args":[20, 20, 80, 20]},
    {"cmd": "DrawLine", "args":[20, 180, 80, 180]},
    {"cmd": "Stroke"}
    ]}'
  end

  def draw_one_body
    '{"canvas_width": 500, "canvas_height": 200, "img_commands": [
    {"cmd": "SetRGBA", "args": [207, 0, 15, 1]},
    {"cmd": "SetLineWidth", "args": [6]},
    {"cmd": "DrawLine", "args":[20, 20, 20, 180]},
    {"cmd": "Stroke"}
    ]}'
  end

  def helper_method
    puts "I helped!"
  end
end