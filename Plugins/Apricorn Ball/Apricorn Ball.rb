APRICORN       = 8  #The global variable used to store the selected apricorn.
Apricorn_hash  = {
  :REDAPRICORN    => :LEVELBALL,
  :YELLOWAPRICORN => :MOONBALL,
  :BLUEAPRICORN   => :LUREBALL,
  :GREENAPRICORN  => :FRIENDBALL,
  :PINKAPRICORN   => :LOVEBALL,
  :WHITEAPRICORN  => :FASTBALL,
  :BLACKAPRICORN  => :HEAVYBALL,
  nil             => nil
}

def pbApricornBall
  $game_variables[APRICORN] = 0
  pbFadeOutIn {
    scene = PokemonBag_Scene.new
    screen = PokemonBagScreen.new(scene,$PokemonBag)
    $game_variables[APRICORN] = screen.pbChooseItemScreen(Proc.new { |item| GameData::Item.get(item).is_apricorn? })
  }
  if $game_variables[APRICORN] == 0
    pbMessage("Come again when you have an apricorn for me.")
  else
    pbMessage("One moment while I forge a ball from this apricorn.")
    pbFadeOutIn {pbWait(60)} 
    pbMessage("Here you go, my latest masterpiece!")
    pbReceiveItem(Apricorn_hash.fetch($game_variables[APRICORN]))
    $PokemonBag.pbDeleteItem($game_variables[APRICORN],1)
  end
end