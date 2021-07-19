#===============================================================================
# * Item Ball Printer - by FL (Credits will be apreciated)
#===============================================================================
#
# This script is for Pokémon Essentials. It prints all item ball events
# locations on txt/Output Window.
#
#===============================================================================
#
# To this script works, put it above main OR convert into a plugin.
#
# The options will appears at debug on pause menu (on "Item options..." 
# submenu). This script doesn't check Common Events.
# 
#===============================================================================

module ItemBallPrinter
  # Exported txt file name.
  TXT_FILE_NAME = "ItemBalls"

  # Sorting mode (besides normal item vs hidden items): 
  # 0 = event id, 1 = item name, 2 = X, 3 = Y
  SORTING = 0
  
  # When false, only check scripts on branches.
  INCLUDE_SCRIPT_COMMANDS = true

  # Include hidden items: 0 = Yes, 1 = No, 2 = Only Hidden Items.
  @@include_hidden_items = 0
  
  def self.include_hidden_items?
    return @@include_hidden_items!=1
  end
  
  def self.include_non_hidden_items?
    return @@include_hidden_items!=2
  end
  
  def self.include_hidden_items
    return @@include_hidden_items
  end
  
  def self.include_hidden_items=(value)
    @@include_hidden_items = value
  end
  
  def self.file_full_name
    return TXT_FILE_NAME+".txt"
  end

  def self.print_items
    self.print_current_map
    self.generate_txt
  end

  def self.generate_txt
    string = "Created at "+Time.now.strftime("%Y-%m-%d %H:%M:%S")
    mapinfos = load_data("Data/MapInfos.rxdata")
    for map_id in 1..999
      item_ball_string = self.get_item_ball_string(map_id, mapinfos)
      next if item_ball_string.count("\n") == 0
      string+=sprintf("\n-------------------------------\n%s",item_ball_string)
    end
    File.open(self.file_full_name, "w"){|file| file.write(string)}
  end

  def self.print_current_map
    string = self.get_item_ball_string($game_map.map_id)
    string+="\nNo item balls" if string.count("\n") == 0
    echoln(string)
  end

  def self.get_item_ball_string(map_id, mapinfos=nil)
    mapinfos = load_data("Data/MapInfos.rxdata") if !mapinfos
    map_file_name = sprintf("Data/Map%03d.rxdata", map_id)
    return "" if !File.exist?(map_file_name)
    map = load_data(map_file_name)
    ret = sprintf("Map ID: %03d. %s", map_id, mapinfos[map_id].name)
    event_and_scripts = self.get_events_and_ball_scripts(map.events.values)
    for i in 0...event_and_scripts.size
      event = event_and_scripts[i][0]
      script = event_and_scripts[i][1]
      item = script.gsub("pbItemBall","").gsub("(","").gsub(")","").gsub(":","").chomp
      line = sprintf(
        "%03d. ID: %03d (%03d,%03d) item: %s  event: %s", 
        i+1, event.id, event.x, event.y, item, event.name
      )
      ret += "\n"+line
    end
    return ret
  end

  # Return an array of arrays with two items: the valid event, script text with item ball
  def self.get_events_and_ball_scripts(events)
    ret = []
    for event in events
      next if !self.include_hidden_items? && self.is_hidden_item?(event)
      next if !self.include_non_hidden_items? && !self.is_hidden_item?(event)
      for page in event.pages
        for command_index in 0...page.list.size
          command = page.list[command_index]
          case command.code
          when 111  # Conditional Branch
            if command.parameters[0] == 12 # Script
              ret.push([event, command.parameters[1]]) if command.parameters[1].include?("pbItemBall")
            end
          when 355  # Script
            next if !INCLUDE_SCRIPT_COMMANDS
            script = command.parameters[0]
            i = command_index+1
            while page.list[i].code == 655
              script+=";"+page.list[i].parameters[0] 
              i+=1
            end
            ret.push([event, script]) if script.include?("pbItemBall")
          end
        end
      end
    end
    return ret.sort{|a,b| 
      self.give_priority_to_event(a[0], a[1]) <=> self.give_priority_to_event(b[0], b[1])
    }
  end

  # Return a score for event. Used for sorting events
  def self.give_priority_to_event(event, script)
    if SORTING==1
      ret = script
      ret = "\x7F" + ret if self.is_hidden_item?(event)
    else
      ret = event.id
      if SORTING>1
        ret+=event.x*(SORTING==2 ? 1_000_000 : 1_000) # SORTING==2 means sort by X
        ret+=event.y*(SORTING==3 ? 1_000_000 : 1_000)
      end
      ret+= 1_000_000_000 if self.is_hidden_item?(event)
    end
    return ret
  end

  def self.is_hidden_item?(event)
    return event.name[/hiddenitem/i]
  end
end

DebugMenuCommands.register("item_ball_printer", {
  "parent"      => "itemsmenu",
  "name"        => _INTL("Item Ball Printer"),
  "description" => _INTL("Prints item balls and hidden items on maps."),
})
DebugMenuCommands.register("item_ball_print_current_map", {
  "parent"      => "item_ball_printer",
  "name"        => _INTL("Print Current Map On Log"),
  "description" => _INTL("Print current map item balls on Output Window."),
  "effect"      => proc {
    ItemBallPrinter.print_current_map
    pbMessage(_INTL("Printed!"))
  }
})
DebugMenuCommands.register("item_ball_print_all", {
  "parent"      => "item_ball_printer",
  "name"        => _INTL("Print All Maps On txt"),
  "description" => _INTL("Print all maps on {1}.", ItemBallPrinter.file_full_name),
  "effect"      => proc {
    msgwindow = pbCreateMessageWindow
    if safeExists?(ItemBallPrinter.file_full_name) && !pbConfirmMessageSerious(
       _INTL("{1} already exists. Overwrite it?",ItemBallPrinter.file_full_name)
    )
      pbDisposeMessageWindow(msgwindow)
      next
    end
    pbMessageDisplay(msgwindow,_INTL("Please wait.\\wtnp[0]"))
    ItemBallPrinter.generate_txt
    pbMessageDisplay(msgwindow,_INTL("File generated."))
    pbDisposeMessageWindow(msgwindow)
  }
})
DebugMenuCommands.register("item_ball_print_hidden_mode", {
  "parent"      => "item_ball_printer",
  "name"        => _INTL("Change Hidden Items Mode"),
  "description" => _INTL("Include hidden items on print?"),
  "effect"      => proc {
    ItemBallPrinter.include_hidden_items = pbShowCommands(
      nil,
      [_INTL("Yes"), _INTL("No"), _INTL("Only include hidden items")],
      ItemBallPrinter.include_hidden_items,
      ItemBallPrinter.include_hidden_items
    )
  }
})