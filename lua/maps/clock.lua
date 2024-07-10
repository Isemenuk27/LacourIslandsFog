local minuteArrows = ents.FindByName( "clock_minute_arrow*" )
local hourArrows = ents.FindByName( "clock_hour_arrow*" )

local Timestamp
local Hours
local Minutes
local Seconds
local hourRollAngle
local minuteRollAng
local oldRoll = 0
local oldRollHour = 0

local function RotateArrows()
	Timestamp = os.time()
	Hours = os.date( "%I", Timestamp )
	Minutes = os.date( "%M", Timestamp )
	Seconds = os.date( "%S", Timestamp )
	hourRollAngle = ( 360 - (30 * (Hours + (Minutes / 60) ) ) )
	minuteRollAng = ( 360 - (6 * (Minutes + (Seconds / 60) ) ) )

	for i,v in ipairs(minuteArrows) do
		if IsValid(v) then
			local ang = v:GetAngles()
			ang:RotateAroundAxis( ang:Forward(),  minuteRollAng - oldRoll )
			v:SetAngles(ang)
		end
	end
	for i,v in ipairs(hourArrows) do
		if IsValid(v) then
			local ang = v:GetAngles()
			ang:RotateAroundAxis( ang:Forward(),  hourRollAngle - oldRollHour )
			v:SetAngles(ang)
		end
	end

	oldRoll = minuteRollAng
	oldRollHour = hourRollAngle
end

local function pulser()
	timer.Simple( 1, function()
		RotateArrows()
		pulser()
	end)
end

pulser()