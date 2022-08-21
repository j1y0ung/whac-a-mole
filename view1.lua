-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- 1) 함수 선언
-- 1-1) 게임 시작 클릭 시 실행되는 함수
local function gotoGame()
	composer.gotoScene("game")
end

-- 1-2) 게임 방법 클릭 시 실행되는 함수
local function gotoHowto()
	composer.gotoScene("howto")
end
------------------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view

	-- 2) UI 설정
	-- 2-1) 배경화면
	local background = display.newImageRect("imgsources/background.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	background.alpha = 0.6 -- 약간 어둡게

	-- 2-2) 제목
	local title = display.newImageRect("imgsources/title.png", 390, 140)
	title.x, title.y = 1070, 140

	-- 2-3) 게임 시작
	local gamestart = display.newImageRect("imgsources/gamestart.png", 340, 140)
	gamestart.x, gamestart.y = 1070, 300

	-- 2-4) 게임 방법
	local howto = display.newImageRect("imgsources/howto.png", 340, 140)
	howto.x, howto.y = 1070, 420

	-- 3) 이벤트 리스너
	-- 3-1) 게임 시작 클릭 시
	gamestart:addEventListener("tap", gotoGame)
	
	-- 3-2) 게임 방법 클릭 시
	howto:addEventListener("tap", gotoHowto)

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