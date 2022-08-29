#===============================================================================
# Automatic Level Scaling Settings
# By Benitex
#===============================================================================

module LevelScalingSettings
  # These two below are the variables that control difficulty
  # (You can set both of them to be the same)
  TRAINER_VARIABLE = 99
  WILD_VARIABLE = 100

  # If evolution levels are not defined when creating a difficulty, these are the default values used
  AUTOMATIC_EVOLUTIONS = false
  DEFAULT_FIRST_EVOLUTION_LEVEL = 20
  DEFAULT_SECOND_EVOLUTION_LEVEL = 40

  # Scales levels but takes original level differences into consideration
  # Don't forget to set random_increase values to 0 when using this setting
  PROPORTIONAL_SCALING = true

  ONLY_SCALE_IF_HIGHER = true   # Levels are not going to scale down even if your pokemon are in a lower level than the opponent level (defined in the PBS)
  ONLY_SCALE_IF_LOWER = false    # Levels are not going to scale up even if your pokemon are in a higher level than the opponent level (defined in the PBS)

  # You can add your own difficulties here, using the function "Difficulty.new(id, fixed_increase, random_increase, first_evolution_level, second_evolution_level)"
  #   "id" is the value stored in TRAINER_VARIABLE or WILD_VARIABLE, defines the active difficulty
  #   "fixed_increase" is a pre defined value that increases the level (optional)
  #   "random_increase" is a random value that increases the level (optional)
  # Note that these variables can also store negative values
  DIFICULTIES = [
    Difficulty.new(id: 0),  
    Difficulty.new(id: 3, random_increase: 0),                      # 1.0.8
    Difficulty.new(id: 7, fixed_increase: 3, random_increase: 3),   # Hard
    Difficulty.new(id: 8),                                          # Average
    Difficulty.new(id: 9, fixed_increase: -2, random_increase: 5),  # Standard Essentials
  ]

  # You can insert the first stage of a custom regional form here
  # Pokemon not included in this array will have their evolution selected randomly among all their possible forms
  POKEMON_WITH_REGIONAL_FORMS = [
    :RATTATA, :SANDSHREW, :VULPIX, :DIGLETT, :MEOWTH, :GEODUDE,
    :GRIMER, :PONYTA, :FARFETCHD, :CORSOLA, :ZIGZAGOON,
    :DARUMAKA, :YAMASK, :STUNFISK, :SLOWPOKE, :ARTICUNO, :ZAPDOS,
    :MOLTRES, :PIKACHU, :EXEGGCUTE, :CUBONE, :KOFFING, :MIMEJR,
    :BURMY, :DEERLING, :ROCKRUFF, :MINIOR, :PUMPKABOO, :PONYTA
  ]
end
