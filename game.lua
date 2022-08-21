-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()


-----------------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view

	-- 1) UI 설정
    -- 1-1) 배경화면
    local background = display.newImageRect("imgsources/background.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	
	-- 1-2) 타이머 글자
	local time = 10
    local cText = display.newText("10", 1100, 300, native.systemFont, 80)
	cText:setFillColor(1, 0.2, 0.2) -- 빨간색

	-- 1-3) 각 구멍에 캐릭터 3개씩 할당
	local hole = {}
	local hole_num -- 1 ~ 9
	local character_num -- 1 ~ 3 : 맞기 전 곰, 일반, 특별 / 4 ~ 6 : 맞은 후 곰, 일반, 특별
	local i, j

	for i = 1, 9, 1 do
		hole[i] = {} -- 2차원 배열
		-- 맞기 전
		hole[i][1] = display.newImageRect("imgsources/bear.png", 150, 150)
		hole[i][2] = display.newImageRect("imgsources/mole.png", 150, 150)
		hole[i][3] = display.newImageRect("imgsources/special_mole.png", 150, 150)
		-- 맞은 후
		hole[i][4] = display.newImageRect("imgsources/bear_hit.png", 200, 200)
		hole[i][5] = display.newImageRect("imgsources/mole_hit.png", 200, 200)
		hole[i][6] = display.newImageRect("imgsources/special_mole_hit.png", 200, 200)
	end

	-- 1-4) 각 구멍의 캐릭터 위치 설정
	for i = 1, 9, 1 do
		for j = 1, 6, 1 do
			-- 캐릭터 안보이게
			hole[i][j].alpha = 0

			-- 각 구멍 위치 설정
			if i == 1 then
				if j >= 4 then
					-- 맞은 캐릭터들 이미지 크기가 좀 더 커서 안맞은 캐릭터들이랑 위치 조금씩 다름
					hole[i][j].x, hole[i][j].y = 233, 134
				else
					hole[i][j].x, hole[i][j].y = 210, 159
				end
			elseif i == 2 then
				if j >= 4 then
					hole[i][j].x, hole[i][j].y = 487, 134
				else
					hole[i][j].x, hole[i][j].y = 464, 159
				end
			elseif i == 3 then
				if j >= 4 then
					hole[i][j].x, hole[i][j].y = 738, 134
				else
					hole[i][j].x, hole[i][j].y = 715, 159
				end
			elseif i == 4 then
				if j >= 4 then
					hole[i][j].x, hole[i][j].y = 233, 330
				else
					hole[i][j].x, hole[i][j].y = 210, 355
				end
			elseif i == 5 then
				if j >= 4 then
					hole[i][j].x, hole[i][j].y = 487, 330
				else
					hole[i][j].x, hole[i][j].y = 464, 355
				end
			elseif i == 6 then
				if j >= 4 then
					hole[i][j].x, hole[i][j].y = 738, 330
				else
					hole[i][j].x, hole[i][j].y = 715, 355
				end
			elseif i == 7 then
				if j >= 4 then
					hole[i][j].x, hole[i][j].y = 233, 526
				else
					hole[i][j].x, hole[i][j].y = 210, 551
				end
			elseif i == 8 then
				if j >= 4 then
					hole[i][j].x, hole[i][j].y = 487, 526
				else
					hole[i][j].x, hole[i][j].y = 464, 551
				end
			elseif i == 9 then
				if j >= 4 then
					hole[i][j].x, hole[i][j].y = 738, 526
				else
					hole[i][j].x, hole[i][j].y = 715, 551
				end
			end
		end
	 end
	 
	-- 2) 캐릭터 클릭 함수
	local score = 0 -- 초기 점수 : 0
	local cText2 = display.newText(score, 1100, 500, native.systemFont, 80)
	cText2:setFillColor(0.2, 0.2, 0.2)

	local function hit(holeN, charN)
		hole[holeN][charN].alpha = 0
		print("현재 클릭한 구멍 : ",holeN)

		if charN == 1 then
			print("현재 때린 캐릭터 : 곰(-1)")
			hole[holeN][4].alpha = 1
			score = score - 1
		elseif charN == 2 then
			print("현재 때린 캐릭터 : 일반두더지(+1)")
			hole[holeN][5].alpha = 1
			score = score + 1
		elseif charN == 3 then
			print("현재 때린 캐릭터 : 특별두더지(+3)")
			hole[holeN][6].alpha = 1
			score = score + 3
		end
		print("현재 점수 : ", score)
		print("------------------------------------------")

		cText2.text = score;
	end

	-- 3) 탭 리스너 함수
	local function tapListener()
		hit(hole_num, character_num) -- 나타난 캐릭터를 탭하면 hit함수 실행
	end

	-- 4) 캐릭터 나타나는 함수
	local function characterAppear()
		hole_num = math.random(1, 9) -- 구멍 번호 랜덤 선택
		character_num = math.random(1, 3) -- 캐릭터 번호 랜덤 선택
		hole[hole_num][character_num].alpha = 1

		hole[hole_num][character_num]:addEventListener("tap", tapListener)
	end

	-- 5) 캐릭터 사라지는 함수
	local function characterDisappear()
		for i = 1, 9, 1 do
			for j = 1, 6, 1 do
				hole[i][j].alpha = 0
			end
		end
	end

	-- 6) 게임 종료 후 결과화면으로 넘어가는 함수
	local function gotoRes()
		composer.setVariable("finalScore", score) -- score값을 finalScore이라는 변수로 넘겨줌
		composer.gotoScene("result")
	end

	-- 7) 타이머
	math.randomseed( os.time() ) -- 난수 생성기
    
    local function Timer(event)
        time = time - 1
        local s = time % 60
		local tDisplay = string.format("%d", s)
		cText.text = tDisplay

		local charAp = timer.performWithDelay(700, characterAppear) -- 0.7초마다 캐릭터 나타나는 함수 호출
		local charDisap = timer.performWithDelay(700, characterDisappear) -- 0.7초마다 캐릭터 사라지는 함수 호출

		-- 시간 끝나면 결과 화면 함수 호출
		if time == 0 then
			gotoRes()
		end
	end

    local tmr1 = timer.performWithDelay(1000, Timer, time) -- 1초마다 Timer 호출
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