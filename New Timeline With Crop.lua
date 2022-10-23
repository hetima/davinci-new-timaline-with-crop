
-- 表示中のクロップ設定で切り出したタイムラインを作成するスクリプト
-- C:\ProgramData\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Edit 辺りに入れるとワークスペースメニューのスクリプトに出てくる
-- 対象タイムラインの「プロジェクト設定を使用」がオンだと動かないためオフにしておく


local pm = resolve:GetProjectManager()
local pj = pm:GetCurrentProject()
local tl = pj:GetCurrentTimeline()
local pool =pj:GetMediaPool()

local test = tl:GetSetting("colorSpaceOutput")
if test ~= "" then
    print("this timeline seems use project setting. please check off")
    return
end

local oldHeight = tl:GetSetting("timelineResolutionHeight")
local oldWidth = tl:GetSetting("timelineResolutionWidth")
local item = tl:GetCurrentVideoItem()
local cropLeft = math.floor(item:GetProperty("CropLeft") + 0.5)
local cropRight = math.floor(item:GetProperty("CropRight") + 0.5)
local cropTop = math.floor(item:GetProperty("CropTop") + 0.5)
local cropBottom = math.floor(item:GetProperty("CropBottom") + 0.5)

newTl = tl:DuplicateTimeline(tl:GetName() .. "_crop")
if newTl ~= nil and pj:SetCurrentTimeline(newTl) then
    local height = oldHeight - cropTop - cropBottom
    local width = oldWidth - cropLeft - cropRight
    if width % 2 ~= 0 then
        width = width + 1
    end
    if height % 2 ~= 0 then
        height = height + 1
    end
    newTl:SetSetting("timelineInputResMismatchBehavior", "centerCrop")
    newTl:SetSetting("timelineResolutionHeight", tostring(height))
    newTl:SetSetting("timelineOutputResolutionHeight", tostring(height))
    newTl:SetSetting("timelineResolutionWidth", tostring(width))
    newTl:SetSetting("timelineOutputResolutionWidth", tostring(width))

    item = newTl:GetCurrentVideoItem()
    local rightGrav = (cropRight/2)/(oldWidth/width)
    local leftGrav = -((cropLeft/2)/(oldWidth/width))
    local topGrav = (cropTop/2)/(oldHeight/height)
    local bottomGrav = -((cropBottom/2)/(oldHeight/height))

    item:SetProperty("Pan", math.floor((rightGrav+leftGrav)))
    item:SetProperty("Tilt", math.floor((topGrav+bottomGrav)))
    item:SetProperty("CropLeft", 0)
    item:SetProperty("CropRight", 0)
    item:SetProperty("CropTop", 0)
    item:SetProperty("CropBottom", 0)

end

