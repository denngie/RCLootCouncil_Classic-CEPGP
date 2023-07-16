local addon = LibStub("AceAddon-3.0"):GetAddon("RCLootCouncil_Classic")
local RCVotingFrame = addon:GetModule("RCVotingFrame")
local RCVFCEPGP = addon:NewModule("RCVFCEPGP", "AceEvent-3.0")

local table = table


function RCVFCEPGP:OnInitialize()
	if not RCVotingFrame.scrollCols then -- RCVotingFrame hasn't been initialized.
		return self:ScheduleTimer("OnInitialize", 0.5)
	end
    self:UpdateColumns()
	self.initialize = true
end

function RCVFCEPGP:GetScrollColIndexFromName(colName)
    for i, v in ipairs(RCVotingFrame.scrollCols) do
        if v.colName == colName then
            return i
        end
    end
end

function RCVFCEPGP:UpdateColumns()
    local CEPGP =
    { name = "PR", DoCellUpdate = self.SetCellPR, colName = "PR", sortnext = self:GetScrollColIndexFromName("response"), width = 30, align = "CENTER", defaultsort = "asc" }
	table.insert(RCVotingFrame.scrollCols, CEPGP)

    self:ResponseSortNext()

    if RCVotingFrame:GetFrame() then
        RCVotingFrame:GetFrame().UpdateSt()
    end
end

function RCVFCEPGP:ResponseSortNext()
    local responseIdx = self:GetScrollColIndexFromName("response")
    local prIdx = self:GetScrollColIndexFromName("PR")

    if responseIdx then
        RCVotingFrame.scrollCols[responseIdx].sortnext = prIdx
    end
end

function RCVFCEPGP.SetCellPR(rowFrame, frame, data, cols, row, realrow, column, fShow, table, ...)
	local name = Ambiguate(data[realrow].name, "short")
	local index = CEPGP_getIndex()
	local EP, GP = CEPGP_getEPGP(name, index);
	local PR = math.floor((EP/GP)*100)/100

	frame.text:SetText(PR)
	data[realrow].cols[column].value = PR or -1
end

function RCVFCEPGP:RCMLAwardSuccess(message, session, winner, status, link, responseText)
	local player = Ambiguate(winner, "short")
	local itemID = CEPGP_getItemID(link)
	local ignore_responses = { Disenchant=true, Banking=true, Free=true, Pass=true, Autopass=true, Awarded=true }

	if not ignore_responses[responseText] and not addon.testMode then
		local amount = CEPGP_calcGP(_, 1, itemID)
		if responseText:find("free") then
			amount = 0
		end

		CEPGP_addGP(player, amount, itemID, link, nil, responseText)
	end
end
RCVFCEPGP:RegisterMessage("RCMLAwardSuccess")
