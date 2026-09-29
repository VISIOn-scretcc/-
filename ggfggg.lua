-- AUTO-PARRY С ПРАВИЛЬНЫМИ КООРДИНАТАМИ
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local autoParry = true
local parryRadius = 20

-- Функция эмуляции касания (там, где кнопка "ОТБИВАТЬ")
local function doParry()
    local viewport = Camera.ViewportSize
    -- Кнопка "ОТБИВАТЬ" находится примерно на 75% от левого края и 75% от верхнего
    local x = viewport.X * 0.75
    local y = viewport.Y * 0.75
    
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 1)
    task.wait(0.05)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 1)
end

-- Основной цикл
task.spawn(function()
    while task.wait(0.05) do
        if not autoParry then continue end
        
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
        
        local root = char.HumanoidRootPart
        
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name == "Ball" then
                local dist = (v.Position - root.Position).Magnitude
                if dist <= parryRadius then
                    doParry()
                    break
                end
            end
        end
    end
end)

print("AUTO-PARRY РАБОТАЕТ! Кнопка: ОТБИВАТЬ")
