#==============================================================================
# "v19.1 Hotfixes" plugin
# This file contains fixes for bugs relating to Debug features or compiling.
# These bug fixes are also in the master branch of the GitHub version of
# Essentials:
# https://github.com/Maruno17/pokemon-essentials
#==============================================================================



#==============================================================================
# Fix for Trainer Type Editor spamming the console with error messages when it
# can't find a trainer sprite to show for the "New Trainer Type" option.
#==============================================================================
class TrainerTypeLister
  def refresh(index)
    @sprite.bitmap.dispose if @sprite.bitmap
    return if index < 0
    begin
      if @ids[index].is_a?(Symbol)
        @sprite.setBitmap(GameData::TrainerType.front_sprite_filename(@ids[index]), 0)
      else
        @sprite.setBitmap(nil)
      end
    rescue
      @sprite.setBitmap(nil)
    end
    if @sprite.bitmap
      @sprite.ox = @sprite.bitmap.width / 2
      @sprite.oy = @sprite.bitmap.height / 2
    end
  end
end

#==============================================================================
# Fixed some game data not being cleared before compiling.
#==============================================================================
module Compiler
  class << self
    alias __hotfixes__compile_encounters compile_encounters
    alias __hotfixes__compile_trainers compile_trainers
  end

  module_function

  def compile_encounters(path = "PBS/encounters.txt")
    GameData::Encounter::DATA.clear
	__hotfixes__compile_encounters(path)
  end

  def compile_trainers(path = "PBS/trainers.txt")
    GameData::Trainer::DATA.clear
	__hotfixes__compile_trainers(path)
  end
end

#==============================================================================
# Fix for messages not being reloaded after the game is compiled.
#==============================================================================
module Compiler
  class << self
    alias __hotfixes__compile_all compile_all
  end

  module_function

  def compile_all(mustCompile)
    __hotfixes__compile_all(mustCompile) { |msg| pbSetWindowText(msg); echoln(msg) }
	return if !mustCompile
    MessageTypes.loadMessageFile("Data/messages.dat") if safeExists?("Data/messages.dat")
  end
end
