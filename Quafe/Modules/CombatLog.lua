local E, C, F, L = unpack(Quafe)  -->Engine, Config, Function, Locale

----------------------------------------------------------------
--> API Localization
----------------------------------------------------------------

local _G = getfenv(0)
local format = string.format
local find = string.find

local min = math.min
local max = math.max
local floor = math.floor
local sqrt = math.sqrt
local sin = math.sin
local cos = math.cos
local rad = math.rad
local acos = math.acos
local atan = math.atan
local rad = math.rad
local modf = math.modf

local insert = table.insert
local remove = table.remove
local wipe = table.wipe

----------------------------------------------------------------
--> 
----------------------------------------------------------------

--"COMBAT_LOG_EVENT"
--"COMBAT_LOG_EVENT_UNFILTERED"
--local timestamp, eventParam, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, Param12, Param13, Param14 = CombatLogGetCurrentEventInfo()

local function CombatLog_Event(frame, event, ...)
	local timestamp, eventParam, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, 
	Param12, Param13, Param14, Param15, Param16, Param17, Param18, Param19, Param20, Param21, Param22, Param23, Param24 = CombatLogGetCurrentEventInfo()
	--Param12 (spellId), Param13 (spellName), Param14 (spellSchool), Param15 (failedType), 
	
	for k, v in pairs(E.CombatLogList) do
		if v.LogEvent and v.LogON then
			v.LogEvent(timestamp, eventParam, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, Param12, Param13, Param14, Param15, Param16, Param17, Param18, Param19, Param20, Param21, Param22, Param23, Param24)
		end
	end
end

local function CombatLog_OnEvent(frame)
	frame: SetScript("OnEvent", function(self, event, ...)
		CombatLog_Event(self, event, ...)
	end)
end

local function BGCL_RgEvent(frame)
	--frame: RegisterEvent("COMBAT_LOG_EVENT") -->过滤后的记录
	frame: RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") -->未过滤的记录
end

local BackgroundCombatLog = CreateFrame("Frame", nil, E)

local function BGCL_Toggle()
	if #(E.CombatLogList) > 0 then
		BGCL_RgEvent(BackgroundCombatLog)
	else
		BackgroundCombatLog: UnregisterAllEvents()
	end
end

local function BGCL_Load()
	CombatLog_OnEvent(BackgroundCombatLog)
	BGCL_Toggle()
end

F.BGCL_Toggle = BGCL_Toggle
BackgroundCombatLog.Load = BGCL_Load
tinsert(E.Module, BackgroundCombatLog)

--SPELL_CAST_START
--SPELL_CAST_FAILED
--SPELL_CAST_SUCCESS