--[[
    //  BAT SCRIPT  \\
]]--

function runBatScript()
    -- Hat ID for Aluminium Baseball Bat
    local hatID = 7063113820
    -- CFrame relative to the Right Arm (adjust as needed)
    local hatCFrame = CFrame.new(0.9, 0.7, -1) * CFrame.Angles(math.rad(-90), math.rad(45), 0)
    local limb = "Right Arm"

    -- Use Bytex's Reanimate function (it loads reanimate.lua and sets up the hat)
    Reanimate(hatID, hatCFrame, limb, false, nil, nil, nil)

    -- Wait for reanimation to finish
    wait(0.5)

    -- Get the reanimated character (the fake one created by Bytex)
    local char = game.Players.LocalPlayer.Character
    if not char then return end

    -- Define joints from the reanimated character
    local root = char:FindFirstChild("HumanoidRootPart")
    local torso = char:FindFirstChild("Torso")
    local head = char:FindFirstChild("Head")
    local rightArm = char:FindFirstChild("Right Arm")
    local leftArm = char:FindFirstChild("Left Arm")
    local rightLeg = char:FindFirstChild("Right Leg")
    local leftLeg = char:FindFirstChild("Left Leg")
    if not (root and torso) then return end

    local RJ = root:FindFirstChild("RootJoint")
    local RS = torso:FindFirstChild("Right Shoulder")
    local LS = torso:FindFirstChild("Left Shoulder")
    local RH = torso:FindFirstChild("Right Hip")
    local LH = torso:FindFirstChild("Left Hip")
    local NECK = torso:FindFirstChild("Neck")
    if not (RJ and RS and LS and RH and LH and NECK) then return end

    -- Reset joints to default (just in case)
    NECK.C0 = CFrame.new(0, 1, 0)
    NECK.C1 = CFrame.new(0, -0.5, 0)
    RJ.C0 = CFrame.new(0, 0, 0)
    RJ.C1 = CFrame.new(0, -1, 0)
    RS.C0 = CFrame.new(0, 0, 0)
    RS.C1 = CFrame.new(0, 0.5, 0)
    LS.C0 = CFrame.new(0, 0, 0)
    LS.C1 = CFrame.new(0, 0.5, 0)
    RH.C0 = CFrame.new(0, 0, 0)
    RH.C1 = CFrame.new(0, 1, 0)
    LH.C0 = CFrame.new(0, 0, 0)
    LH.C1 = CFrame.new(0, 1, 0)

    -- Animation variables
    local sine = 1
    local speed = 1
    local Mode = "1"  -- default idle
    local humanoid = char:WaitForChild("Humanoid")

    -- Mouse for attack and mode switching
    local mouse = game.Players.LocalPlayer:GetMouse()

    -- Mode switching (Q and E)
    mouse.KeyDown:Connect(function(k)
        if k == "q" then
            Mode = "1"
            humanoid.WalkSpeed = 16
        elseif k == "e" then
            Mode = "2"
            humanoid.WalkSpeed = 35
        end
    end)

    -- Attack combo (click)
    mouse.Button1Down:Connect(function()
        Mode = "Attack1"
        wait(0.1)
        Mode = "Attack2"
        wait(0.1)
        Mode = "Attack3"
        wait(0.3)
        Mode = "2"  -- change to desired mode after attack
    end)

    -- Main animation loop
    local rs = game:GetService("RunService")
    coroutine.wrap(function()
        while char and char.Parent do
            sine = sine + speed
            local vel = root.Velocity
            local yVel = vel.Y
            local mag = vel.Magnitude

            local isWalking = mag > 1 and mag < 20
            local isRunning = mag >= 20
            local isJumping = yVel > 1
            local isFalling = yVel < -1
            local isIdle = mag < 2 and not isJumping and not isFalling

            if Mode == "1" then
                humanoid.WalkSpeed = 16
                if isJumping then
                    NECK.C0 = NECK.C0:Lerp(CFrame.new(0,1,0), 0.2)
                    RJ.C0 = RJ.C0:Lerp(CFrame.new(0,-1,0), 0.2)
                    RS.C0 = RS.C0:Lerp(CFrame.new(1.5,0.5,0) * CFrame.Angles(0, math.rad(20), math.rad(45)), 0.2)
                    LS.C0 = LS.C0:Lerp(CFrame.new(-1.5,0.5,0) * CFrame.Angles(0, math.rad(-20), math.rad(-45)), 0.2)
                    RH.C0 = RH.C0:Lerp(CFrame.new(0.5,0,-1) * CFrame.Angles(math.rad(-20),0,0), 0.2)
                    LH.C0 = LH.C0:Lerp(CFrame.new(-0.5,0,-1) * CFrame.Angles(math.rad(-15),0,0), 0.2)
                elseif isFalling then
                    NECK.C0 = NECK.C0:Lerp(CFrame.new(0,1,0), 0.2)
                    RJ.C0 = RJ.C0:Lerp(CFrame.new(0,-1,0), 0.2)
                    RS.C0 = RS.C0:Lerp(CFrame.new(1.5,0.5,0) * CFrame.Angles(0, math.rad(20), math.rad(45)), 0.2)
                    LS.C0 = LS.C0:Lerp(CFrame.new(-1.5,0.5,0) * CFrame.Angles(0, math.rad(-20), math.rad(-45)), 0.2)
                    RH.C0 = RH.C0:Lerp(CFrame.new(0.5,0,-1) * CFrame.Angles(math.rad(-20),0,0), 0.2)
                    LH.C0 = LH.C0:Lerp(CFrame.new(-0.5,0,-1) * CFrame.Angles(math.rad(-15),0,0), 0.2)
                elseif isIdle then
                    NECK.C0 = NECK.C0:Lerp(CFrame.new(0,1,0), 0.2)
                    RJ.C0 = RJ.C0:Lerp(CFrame.new(0, -1 + 0.05*math.sin(sine/50), 0), 0.2)
                    RS.C0 = RS.C0:Lerp(CFrame.new(1.5, 0.5 + 0.05*math.sin(sine/50), 0), 0.2)
                    LS.C0 = LS.C0:Lerp(CFrame.new(-1.5, 0.5 + 0.05*math.sin(sine/50), 0), 0.2)
                    RH.C0 = RH.C0:Lerp(CFrame.new(0.5, -1 - 0.05*math.sin(sine/50), 0), 0.2)
                    LH.C0 = LH.C0:Lerp(CFrame.new(-0.5, -1 - 0.05*math.sin(sine/50), 0), 0.2)
                elseif isWalking then
                    NECK.C0 = NECK.C0:Lerp(CFrame.new(0,1,0), 0.2)
                    RJ.C0 = RJ.C0:Lerp(CFrame.new(0, -1.1 - 0.1*math.cos(sine/10), 0) * CFrame.Angles(math.rad(-10), math.rad(5*math.cos(sine/20)), math.rad(5*math.cos(sine/20))), 0.2)
                    RS.C0 = RS.C0:Lerp(CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(-60*math.cos(sine/20)), 0, 0), 0.2)
                    LS.C0 = LS.C0:Lerp(CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(60*math.cos(sine/20)), 0, 0), 0.2)
                    RH.C0 = RH.C0:Lerp(CFrame.new(0.5, -1 - 0.2*math.sin(sine/20), -0.3*math.cos(sine/20)) * CFrame.Angles(math.rad(60*math.cos(sine/20)), 0, 0), 0.2)
                    LH.C0 = LH.C0:Lerp(CFrame.new(-0.5, -1 + 0.2*math.sin(sine/20), 0.3*math.cos(sine/20)) * CFrame.Angles(math.rad(-60*math.cos(sine/20)), 0, 0), 0.2)
                end
            elseif Mode == "2" then
                humanoid.WalkSpeed = 35
                if isJumping then
                    NECK.C0 = NECK.C0:Lerp(CFrame.new(0,1,0), 0.2)
                    RJ.C0 = RJ.C0:Lerp(CFrame.new(0,-1,0), 0.2)
                    RS.C0 = RS.C0:Lerp(CFrame.new(1.5,0.5,0) * CFrame.Angles(0, math.rad(20), math.rad(45)), 0.2)
                    LS.C0 = LS.C0:Lerp(CFrame.new(-1.5,0.5,0) * CFrame.Angles(0, math.rad(-20), math.rad(-45)), 0.2)
                    RH.C0 = RH.C0:Lerp(CFrame.new(0.5,0,-1) * CFrame.Angles(math.rad(-20),0,0), 0.2)
                    LH.C0 = LH.C0:Lerp(CFrame.new(-0.5,0,-1) * CFrame.Angles(math.rad(-15),0,0), 0.2)
                elseif isFalling then
                    NECK.C0 = NECK.C0:Lerp(CFrame.new(0,1,0), 0.2)
                    RJ.C0 = RJ.C0:Lerp(CFrame.new(0,-1,0), 0.2)
                    RS.C0 = RS.C0:Lerp(CFrame.new(1.5,0.5,0) * CFrame.Angles(0, math.rad(20), math.rad(45)), 0.2)
                    LS.C0 = LS.C0:Lerp(CFrame.new(-1.5,0.5,0) * CFrame.Angles(0, math.rad(-20), math.rad(-45)), 0.2)
                    RH.C0 = RH.C0:Lerp(CFrame.new(0.5,0,-1) * CFrame.Angles(math.rad(-20),0,0), 0.2)
                    LH.C0 = LH.C0:Lerp(CFrame.new(-0.5,0,-1) * CFrame.Angles(math.rad(-15),0,0), 0.2)
                elseif isIdle then
                    NECK.C0 = NECK.C0:Lerp(CFrame.new(0,1,0), 0.2)
                    RJ.C0 = RJ.C0:Lerp(CFrame.new(0, -1 + 0.05*math.sin(sine/50), 0), 0.2)
                    RS.C0 = RS.C0:Lerp(CFrame.new(1, 0.05*math.sin(sine/50), -0.5) * CFrame.Angles(math.rad(100), math.rad(13.23), math.rad(-24.98)), 0.2)
                    LS.C0 = LS.C0:Lerp(CFrame.new(-0.14, -0.14 + 0.05*math.sin(sine/50), -0.5) * CFrame.Angles(math.rad(90), math.rad(20.87), math.rad(13.23)), 0.2)
                    RH.C0 = RH.C0:Lerp(CFrame.new(0.5, -1 - 0.05*math.sin(sine/50), 0), 0.2)
                    LH.C0 = LH.C0:Lerp(CFrame.new(-0.5, -1 - 0.05*math.sin(sine/50), 0), 0.2)
                elseif isRunning then
                    NECK.C0 = NECK.C0:Lerp(CFrame.new(0,1,0), 0.2)
                    RJ.C0 = RJ.C0:Lerp(CFrame.new(0, -1 + 0.1*math.sin(sine/7.5), 0) * CFrame.Angles(math.rad(-17.34), 0, 0), 0.2)
                    RS.C0 = RS.C0:Lerp(CFrame.new(1, 0.1*math.sin(sine/7.5), -0.5) * CFrame.Angles(math.rad(50), math.rad(13.23), math.rad(-24.98)), 0.2)
                    LS.C0 = LS.C0:Lerp(CFrame.new(-0.14, -0.14 + 0.1*math.sin(sine/7.5), -0.5) * CFrame.Angles(math.rad(50), math.rad(20.87), math.rad(13.23)), 0.2)
                    RH.C0 = RH.C0:Lerp(CFrame.new(0.5, -1 - 0.2*math.sin(sine/15), -0.5*math.cos(sine/15)) * CFrame.Angles(math.rad(60*math.cos(sine/15)), 0, 0), 0.2)
                    LH.C0 = LH.C0:Lerp(CFrame.new(-0.5, -1 + 0.2*math.sin(sine/15), 0.4*math.cos(sine/15)) * CFrame.Angles(math.rad(-60*math.cos(sine/15)), 0, 0), 0.2)
                end
            elseif Mode == "Attack1" then
                RS.C0 = RS.C0:Lerp(CFrame.new(1, -0.5, 0) * CFrame.Angles(math.rad(120), math.rad(-35), 0), 0.2)
                LS.C0 = LS.C0:Lerp(CFrame.new(0, 0.25, -0.5) * CFrame.Angles(math.rad(90), math.rad(-15), math.rad(45)), 0.2)
            elseif Mode == "Attack2" then
                RS.C0 = RS.C0:Lerp(CFrame.new(1, -0.5, 0) * CFrame.Angles(math.rad(120), math.rad(-90), 0), 0.2)
                LS.C0 = LS.C0:Lerp(CFrame.new(0, 0.25, -0.5) * CFrame.Angles(math.rad(90), math.rad(-2.06), math.rad(45)), 0.2)
            elseif Mode == "Attack3" then
                RJ.C0 = RJ.C0:Lerp(CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-10), math.rad(20), 0), 0.2)
                RS.C0 = RS.C0:Lerp(CFrame.new(0, 0, -0.5) * CFrame.Angles(math.rad(188.99), math.rad(-193.1), math.rad(97.29)), 0.2)
                LS.C0 = LS.C0:Lerp(CFrame.new(-1, 0, 0.5) * CFrame.Angles(math.rad(89.64), math.rad(13.23), math.rad(-32.62)), 0.2)
            end

            rs.RenderStepped:Wait()
        end
    end)()
end
