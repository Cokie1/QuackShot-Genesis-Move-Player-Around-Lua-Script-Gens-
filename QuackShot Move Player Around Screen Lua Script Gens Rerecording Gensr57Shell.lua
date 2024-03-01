-- Early Phase Quackshot Movew Player Around Screen Lua Script For Gens Rerecrod and Genr57Shell
-- cokie

rl = memory.readlong
wl = memory.writelong


function asword(v) return AND(v,0xFFFF) end

Player_X_Addr = 0xFFA2D0
Player_Y_Addr = 0xFFA2D4

X = rl(Player_X_Addr)
Y = rl(Player_Y_Addr)

KEY_UP = "Y"
KEY_DOWN = "H"
KEY_LEFT = "G"
KEY_RIGHT = "J"

INP_PREVIOUS = input.read();
INP 	     = input.read();
INP_PRESS    = input.read();

INCREMENET = 0x100000

function InpUpdate()
		-- Load inputs
		INP_PREVIOUS = copytable(INP);
		INP = input.read();
		
		-- Update press events
		for k, v in pairs(INP) do
			INP_PRESS[k] = nil;
			
			local v_prev = INP_PREVIOUS[k];
			if v_prev == nil and v == true then
				INP_PRESS[k] = true;		-- Key has been pressed
			else 
				INP_PRESS[k] = nil;		-- Key has not been pressed
			end
		end
	end


memory.registerwrite(Player_X_Addr,4,function(address)
	local xtemp = rl(address)
	if xtemp ~= X then
		wl(address,X)
	end	
end)

memory.registerwrite(Player_Y_Addr,4,function(address)
	local ytemp = rl(address)
	if ytemp ~= Y then
		wl(address,Y)
	end	
end)


while true do
	InpUpdate()

	if INP_PRESS[KEY_UP] then
		Y = Y - INCREMENET
	end
	

	if INP_PRESS[KEY_DOWN] then
		Y = Y + INCREMENET
	end

	if INP_PRESS[KEY_LEFT] then
		X = X - INCREMENET 
	end

	if INP_PRESS[KEY_RIGHT] then
		X = X + INCREMENET 
	end

	wl(Player_X_Addr,X)
	wl(Player_Y_Addr,Y)
	

	gens.frameadvance()
end
