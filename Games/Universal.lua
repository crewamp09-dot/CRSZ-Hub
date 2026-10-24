-- ===================================================
-- CRSZ HUB | Universal Module (FlowHub Style UI)
-- ===================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Eski UI varsa temizle
if CoreGui:FindFirstChild("CRSZ_FlowHubUI") then
    CoreGui.CRSZ_FlowHubUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "CRSZ_FlowHubUI"

-- Main Frame (Sol Menülü FlowHub Düzeni)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 560, 0, 340)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(130, 60, 255)
MainStroke.Thickness = 1.5

-- Sidebar (Sol Menü)
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 140, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

local LogoLbl = Instance.new("TextLabel", Sidebar)
LogoLbl.Size = UDim2.new(1, 0, 0, 40)
LogoLbl.Text = "⚡ CRSZ HUB"
LogoLbl.TextColor3 = Color3.fromRGB(240, 240, 255)
LogoLbl.Font = Enum.Font.GothamBlack
LogoLbl.TextSize = 13
LogoLbl.BackgroundTransparency = 1

local TabContainer = Instance.new("Frame", Sidebar)
TabContainer.Size = UDim2.new(1, -12, 1, -50)
TabContainer.Position = UDim2.new(0, 6, 0, 45)
TabContainer.BackgroundTransparency = 1

local TabListLayout = Instance.new("UIListLayout", TabContainer)
TabListLayout.Padding = UDim.new(0, 6)

-- Content Area (Sağ İçerik Alanı)
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -155, 1, -10)
ContentArea.Position = UDim2.new(0, 150, 0, 5)
ContentArea.BackgroundTransparency = 1

local Tabs = {}

local function CreateTab(tabName)
    local TabBtn = Instance.new("TextButton", TabContainer)
    TabBtn.Size = UDim2.new(1, 0, 0, 30)
    TabBtn.Text = tabName
    TabBtn.TextColor3 = Color3.fromRGB(160, 160, 180)
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextSize = 10
    TabBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

    local TabPage = Instance.new("ScrollingFrame", ContentArea)
    TabPage.Size = UDim2.new(1, 0, 1, 0)
    TabPage.BackgroundTransparency = 1
    TabPage.Visible = false
    TabPage.ScrollBarThickness = 2
    TabPage.ScrollBarImageColor3 = Color3.fromRGB(130, 60, 255)

    local PageLayout = Instance.new("UIListLayout", TabPage)
    PageLayout.Padding = UDim.new(0, 8)

    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
            t.Btn.TextColor3 = Color3.fromRGB(160, 160, 180)
            t.Page.Visible = false
        end
        TabBtn.BackgroundColor3 = Color3.fromRGB(130, 60, 255)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabPage.Visible = true
    end)

    local tabObj = {Btn = TabBtn, Page = TabPage}
    table.insert(Tabs, tabObj)
    
    if #Tabs == 1 then
        TabBtn.BackgroundColor3 = Color3.fromRGB(130, 60, 255)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabPage.Visible = true
    end

    return TabPage
end

-- Tablar
local MainTab = CreateTab("🚀 Main / Player")
local VisualsTab = CreateTab("👁️ Visuals")
local MiscTab = CreateTab("⚙️ Misc")

-- UI Eleman Fonksiyonları (Button, Toggle)
local function AddButton(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, -10, 0, 32)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(230, 230, 250)
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextSize = 11
    Btn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local function AddToggle(parent, text, defaultState, callback)
    local state = defaultState or false
    local ToggleBtn = Instance.new("TextButton", parent)
    ToggleBtn.Size = UDim2.new(1, -10, 0, 32)
    ToggleBtn.Text = text .. " : " .. (state and "ON" or "OFF")
    ToggleBtn.TextColor3 = state and Color3.fromRGB(130, 255, 130) or Color3.fromRGB(255, 130, 130)
    ToggleBtn.Font = Enum.Font.GothamMedium
    ToggleBtn.TextSize = 11
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        ToggleBtn.Text = text .. " : " .. (state and "ON" or "OFF")
        ToggleBtn.TextColor3 = state and Color3.fromRGB(130, 255, 130) or Color3.fromRGB(255, 130, 130)
        callback(state)
    end)
    return ToggleBtn
end

-- ===================================================
-- MAIN / PLAYER ÖZELLİKLERİ
-- ===================================================

AddButton(MainTab, "⚡ WalkSpeed Boost (50)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end
end)

AddButton(MainTab, "🚀 JumpPower Boost (100)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 100
    end
end)

local NoclipState = false
AddToggle(MainTab, "🧱 Noclip", false, function(state)
    NoclipState = state
end)

RunService.Stepped:Connect(function()
    if NoclipState and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- ===================================================
-- VISUALS ÖZELLİKLERİ
-- ===================================================

local ESPState = false
AddToggle(VisualsTab, "👁️ Player ESP (Highlight)", false, function(state)
    ESPState = state
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if state then
                if not plr.Character:FindFirstChild("CRSZ_ESP") then
                    local hl = Instance.new("Highlight", plr.Character)
                    hl.Name = "CRSZ_ESP"
                    hl.FillColor = Color3.fromRGB(130, 60, 255)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            else
                if plr.Character:FindFirstChild("CRSZ_ESP") then
                    plr.Character.CRSZ_ESP:Destroy()
                end
            end
        end
    end
end)

-- ===================================================
-- MISC ÖZELLİKLERİ
-- ===================================================

AddButton(MiscTab, "🔄 Rejoin Game", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

print("⚡ CRSZ Hub Universal Modülü Aktif!")
