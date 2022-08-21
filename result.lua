-----------------------------------------------------------------------------------------
--
-- result.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

-- 1) game.lua에서 finalScore값 받아옴
local score = composer.getVariable("finalScore")

function scene:create( event )
    local sceneGroup = self.view
    
	-- 2) UI 설정
    -- 2-1) 배경화면
	local background = display.newImageRect("imgsources/background.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	background.alpha = 0.6
    
    -- 2-2) 점수
    local scoreText = display.newText(score.."점", 1100, 300, native.systemFont, 80)
    -- 문자열 합치는 법 : 문자열 .. 문자열
    scoreText.x, scoreText.y = display.contentWidth / 2, display.contentHeight / 2
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