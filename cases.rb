require_relative 'app'

class Cases < App
  puts '--------------------------------------------------'
  puts 'Welcome to the Inventory Tracker!'

  def on_start
    puts super
    input = gets.chomp
    process_command(input)
  end

  def process_command(command)
    case command
    when 'exit'
      exit_app
    when 'generate_report'
      generate_report(@inventory_tracker)
      on_start
    else
      show_menu(command)
    end
  end

  def show_menu(command)
    par = command.split
    puts 'Please include a full command' if par.length < 2

    return on_start unless par.length > 2

    case par[0]
    when 'register'
      register_item(par[1], par[2][1..].to_f)
    when 'checkin'
      check_in_item(par[1], par[2].to_i)
    when 'order'
      order_item(par[1], par[2], par[3].to_i)
    else
      puts 'Command does not exist!'
    end

    on_start
  end
end
