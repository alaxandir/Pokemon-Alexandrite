class PokemonBerryHelper_Scene
    def pbUpdate
      pbUpdateSpriteHash(@sprites)
    end
  
    def pbStartScene
      @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
      @viewport.z = 99999
      @sprites = {}
      @sprites["card"] = IconSprite.new(0,0,@viewport)
      @sprites["card"].setBitmap("Graphics/Pictures/berry_guide")
      pbFadeInAndShow(@sprites) { pbUpdate }
    end

  
    def pbBerryHelper
      pbSEPlay("GUI trainer card open")
      loop do
        Graphics.update
        Input.update
        pbUpdate
        if Input.trigger?(Input::BACK)
          pbPlayCloseMenuSE
          break
        end
      end
    end
  
    def pbEndScene
      pbFadeOutAndHide(@sprites) { pbUpdate }
      pbDisposeSpriteHash(@sprites)
      @viewport.dispose
    end
  end
  
  #===============================================================================
  #
  #===============================================================================
  class PokemonBerryHelper_Screen
    def initialize(scene)
      @scene = scene
    end
  
    def pbStartScreen
      @scene.pbStartScene
      @scene.pbBerryHelper
      @scene.pbEndScene
    end
  end