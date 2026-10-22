-- ZOLRAX AUTO-CODE
-- Prototype avec interface et assemblage manuel des fragments.
-- La détection automatique des annonces globales reste à implémenter.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local guiParent = CoreGui

pcall(function()
    if gethui then
        guiParent = gethui()
    end
end)

pcall(function()
    local old = guiParent:FindFirstChild("ZolraxAutoCode")
    if old then
        old:Destroy()
    end
end)

local function make(className, props, parent)
    local obj = Instance.new(className)

    for k, v in pairs(props or {}) do
        obj[k] = v
    end

    obj.Parent = parent
    return obj
end

local theme = {
    bg = Color3.fromRGB(18, 19, 29),
    panel = Color3.fromRGB(28, 30, 45),
    panel2 = Color3.fromRGB(36, 39, 58),
    accent = Color3.fromRGB(143, 108, 255),
    text = Color3.fromRGB(242, 243, 255),
    muted = Color3.fromRGB(164, 169, 194),
    green = Color3.fromRGB(99, 225, 164),
    red = Color3.fromRGB(255, 116, 135),
}

local screen = make("ScreenGui", {
    Name = "ZolraxAutoCode",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, guiParent)

local main = make("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(610, 430),
    Position = UDim2.new(0.5, -305, 0.5, -215),
    BackgroundColor3 = theme.bg,
    BorderSizePixel = 0,
}, screen)

make("UICorner", {
    CornerRadius = UDim.new(0, 14)
}, main)

make("UIStroke", {
    Color = theme.accent,
    Thickness = 1.3,
    Transparency = 0.15
}, main)

local top = make("Frame", {
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundColor3 = theme.panel,
    BorderSizePixel = 0,
}, main)

make("UICorner", {
    CornerRadius = UDim.new(0, 14)
}, top)

make("Frame", {
    Position = UDim2.new(0, 0, 1, -14),
    Size = UDim2.new(1, 0, 0, 14),
    BackgroundColor3 = theme.panel,
    BorderSizePixel = 0,
}, top)

make("TextLabel", {
    Position = UDim2.fromOffset(18, 7),
    Size = UDim2.fromOffset(330, 27),
    BackgroundTransparency = 1,
    Text = "ZOLRAX / AUTO-CODE",
    TextColor3 = theme.text,
    TextSize = 21,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, top)

make("TextLabel", {
    Position = UDim2.fromOffset(19, 33),
    Size = UDim2.fromOffset(350, 16),
    BackgroundTransparency = 1,
    Text = "GLOBAL FRAGMENT ASSEMBLER • RIDDLE HELPER",
    TextColor3 = theme.muted,
    TextSize = 10,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
}, top)

local close = make("TextButton", {
    Position = UDim2.new(1, -43, 0, 12),
    Size = UDim2.fromOffset(29, 29),
    Text = "×",
    TextSize = 22,
    Font = Enum.Font.GothamBold,
    TextColor3 = theme.text,
    BackgroundColor3 = theme.panel2,
    BorderSizePixel = 0,
}, top)

make("UICorner", {
    CornerRadius = UDim.new(0, 8)
}, close)

close.MouseButton1Click:Connect(function()
    screen:Destroy()
end)

local status = make("TextLabel", {
    Position = UDim2.fromOffset(18, 70),
    Size = UDim2.new(1, -36, 0, 24),
    BackgroundTransparency = 1,
    Text = "READY • Add announcement fragments below",
    TextColor3 = theme.green,
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
}, main)

make("TextLabel", {
    Position = UDim2.fromOffset(18, 101),
    Size = UDim2.new(1, -36, 0, 20),
    BackgroundTransparency = 1,
    Text = "ANNOUNCEMENT / FRAGMENT",
    TextColor3 = theme.muted,
    TextSize = 11,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, main)

local input = make("TextBox", {
    Position = UDim2.fromOffset(18, 125),
    Size = UDim2.new(1, -36, 0, 42),
    BackgroundColor3 = theme.panel,
    TextColor3 = theme.text,
    PlaceholderColor3 = theme.muted,
    PlaceholderText = "Paste a global message or code fragment...",
    Text = "",
    ClearTextOnFocus = false,
    TextSize = 13,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    BorderSizePixel = 0,
}, main)

make("UICorner", {
    CornerRadius = UDim.new(0, 8)
}, input)

make("UIPadding", {
    PaddingLeft = UDim.new(0, 12),
    PaddingRight = UDim.new(0, 10),
}, input)

local countLabel = make("TextLabel", {
    Position = UDim2.fromOffset(18, 175),
    Size = UDim2.fromOffset(210, 22),
    BackgroundTransparency = 1,
    Text = "FRAGMENTS 0 / 5",
    TextColor3 = theme.muted,
    TextSize = 11,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, main)

local fragments = {}
local seen = {}

local list = make("TextLabel", {
    Position = UDim2.fromOffset(18, 201),
    Size = UDim2.new(0.50, -24, 0, 112),
    BackgroundColor3 = theme.panel,
    TextColor3 = theme.text,
    Text = "No fragments yet.",
    TextSize = 12,
    Font = Enum.Font.Code,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    BorderSizePixel = 0,
}, main)

make("UICorner", {
    CornerRadius = UDim.new(0, 8)
}, list)

make("UIPadding", {
    PaddingLeft = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 8),
}, list)

make("TextLabel", {
    Position = UDim2.new(0.50, 6, 0, 175),
    Size = UDim2.new(0.50, -24, 0, 22),
    BackgroundTransparency = 1,
    Text = "ASSEMBLED CODE",
    TextColor3 = theme.muted,
    TextSize = 11,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, main)

local result = make("TextBox", {
    Position = UDim2.new(0.50, 6, 0, 201),
    Size = UDim2.new(0.50, -24, 0, 112),
    BackgroundColor3 = theme.panel,
    TextColor3 = theme.green,
    PlaceholderColor3 = theme.muted,
    PlaceholderText = "Code appears here...",
    Text = "",
    ClearTextOnFocus = false,
    TextEditable = false,
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    BorderSizePixel = 0,
}, main)

make("UICorner", {
    CornerRadius = UDim.new(0, 8)
}, result)

make("UIPadding", {
    PaddingLeft = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 8),
}, result)

local function button(text, x, width)
    local b = make("TextButton", {
        Position = UDim2.fromOffset(x, 330),
        Size = UDim2.fromOffset(width, 36),
        BackgroundColor3 = theme.panel2,
        Text = text,
        TextColor3 = theme.text,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
    }, main)

    make("UICorner", {
        CornerRadius = UDim.new(0, 8)
    }, b)

    return b
end

local add = button("ADD FRAGMENT", 18, 142)
local reset = button("RESET", 170, 92)
local copy = button("COPY CODE", 272, 118)
local solve = button("RIDDLE HINT", 400, 172)

local hint = make("TextLabel", {
    Position = UDim2.fromOffset(18, 377),
    Size = UDim2.new(1, -36, 0, 38),
    BackgroundTransparency = 1,
    Text = "Paste each announcement part in order. Automatic global-message detection is not implemented yet.",
    TextColor3 = theme.muted,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
}, main)

local function refresh()
    countLabel.Text = ("FRAGMENTS %d / 5"):format(#fragments)

    if #fragments == 0 then
        list.Text = "No fragments yet."
    else
        local lines = {}

        for i, part in ipairs(fragments) do
            lines[#lines + 1] = ("%d. %s"):format(i, part)
        end

        list.Text = table.concat(lines, "\n")
    end

    result.Text = table.concat(fragments, "")
end

local function addFragment()
    local text = input.Text:gsub("^%s+", ""):gsub("%s+$", "")

    if text == "" then
        status.Text = "WAITING • Paste a fragment first"
        status.TextColor3 = theme.red
        return
    end

    local extracted = text:match(
        "[Cc][Oo][Dd][Ee]%s+[Ii][Ss]%s*[:%-]?%s*(.+)"
    )

    if extracted then
        text = extracted:gsub("^%s+", "")
    end

    text = text:gsub("[%c]", "")

    if seen[text] then
        status.Text = "DUPLICATE • This fragment was already added"
        status.TextColor3 = theme.red
        return
    end

    if #fragments >= 5 then
        status.Text = "LIMIT • Reset before adding another code"
        status.TextColor3 = theme.red
        return
    end

    table.insert(fragments, text)
    seen[text] = true
    input.Text = ""

    status.Text = ("ADDED • Fragment %d captured"):format(#fragments)
    status.TextColor3 = theme.green

    refresh()
end

add.MouseButton1Click:Connect(addFragment)

input.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        addFragment()
    end
end)

reset.MouseButton1Click:Connect(function()
    table.clear(fragments)
    table.clear(seen)

    result.Text = ""
    status.Text = "RESET • Ready for the next code"
    status.TextColor3 = theme.green

    refresh()
end)

copy.MouseButton1Click:Connect(function()
    if result.Text == "" then
        status.Text = "NOTHING TO COPY • Add fragments first"
        status.TextColor3 = theme.red
        return
    end

    local ok = pcall(function()
        if setclipboard then
            setclipboard(result.Text)
        else
            error("clipboard unavailable")
        end
    end)

    if ok then
        status.Text = "COPIED • Code sent to clipboard"
        status.TextColor3 = theme.green
    else
        status.Text = "COPY UNAVAILABLE • Select the code manually"
        status.TextColor3 = theme.red
    end
end)

solve.MouseButton1Click:Connect(function()
    local text = input.Text

    if text == "" then
        hint.Text = "Paste the riddle into the input first, then press RIDDLE HINT."
        return
    end

    local lower = text:lower()
    local answer

    if lower:find("first letter") or lower:find("starts with") then
        answer = "Hint: identify the named word and take its first letter."
    elseif lower:find("reverse") or lower:find("backwards") then
        answer = "Hint: try reversing the relevant word or sequence."
    elseif lower:find("add") or lower:find("sum") or lower:find("plus") then
        answer = "Hint: look for numbers and calculate their sum."
    elseif lower:find("odd one out") then
        answer = "Hint: compare the items and find the one that breaks the pattern."
    else
        answer = "Look for wordplay, numbers, initials, patterns, or ordering clues."
    end

    hint.Text = answer
end)

local dragging
local dragStart
local startPos

top.InputBegan:Connect(function(inputObj)
    if inputObj.UserInputType == Enum.UserInputType.MouseButton1
    or inputObj.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = inputObj.Position
        startPos = main.Position

        inputObj.Changed:Connect(function()
            if inputObj.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(inputObj)
    if dragging
    and (
        inputObj.UserInputType == Enum.UserInputType.MouseMovement
        or inputObj.UserInputType == Enum.UserInputType.Touch
    ) then

        local delta = inputObj.Position - dragStart

        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

refresh()
