-----------------------------------------------------------------------------------------
--
-- howto.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

-- 1) 게임 시작 클릭 시 실행되는 함수
local function playGame()
    composer.gotoScene("game")
end

-----------------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view

	-- 2) UI 설정
    -- 2-1) 게임 방법 설명
	local background = display.newImageRect("imgsources/howto_view.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	-- 2-2) 게임 시작
	local gamestart = display.newImageRect("imgsources/howto_gamestart.png", 300, 150)
	gamestart.x, gamestart.y = 1130, 650

	-- 3) 게임 시작 클릭 이벤트 리스너
	gamestart:addEventListener("tap", playGame)

	-------------------------------------------------------------------------------------------------------------------------------------------	
end

function scene:show( event )
end

function scene:hide( event )
end

function scene:destroy( event )
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene