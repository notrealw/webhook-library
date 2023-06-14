---@diagnostic disable: undefined-global
local Library = {
    Webhook = nil
}

local Headers = {["content-type"] = "application/json"}

function Library:Send(content)
    local PlayerData =
    {
       ["content"] = content,
    }

    local PlayerData = game:GetService('HttpService'):JSONEncode(PlayerData)

    request({Url=Library.Webhook, Body=PlayerData, Method="POST", Headers=Headers})
end

function Library:CreateEmbed(args)
    local embed = {}

    local username = args.Username
    local avatar = args.AvatarURL
    local content = args.Content
    local title = args.Title
    local url = args.Url
    local description = args.Description
    local color = args.Color
    local thumbnail = args.Thumbnail
    local image = args.Image

    local PlayerData =
    {
        ["username"] = nil,
        ["avatar_url"] = nil,
        ["content"] = nil,
        ["embeds"] = {
        {
            ["author"] = {
                ["name"] = nil,
                ["url"] = nil,
                ["icon_url"] = nil
            },
            ["title"] = nil,
            ["url"] = nil,
            ["description"] = nil,
            ["color"] = nil,
            ["thumbnail"] = {
                ["url"] = nil
            },
            ["image"] = {
                ["url"] = nil
            },
            ["fields"] = {},
            ["footer"] = {
                ["text"] = nil,
                ["icon_url"] = nil
            },

        },
    },
}

    if content then
        PlayerData.content = content
    end

    if username then
        PlayerData.username = username
    end

    if avatar then
        PlayerData.avatar_url = avatar
    end

    if title then
        PlayerData["embeds"][1]["title"] = title
    end

    if url then
        PlayerData["embeds"][1]["url"] = url
    end

    if description then
        PlayerData["embeds"][1]["description"] = description
    end

    if color then
        PlayerData["embeds"][1]["color"] = color
    end

    if thumbnail then
        PlayerData["embeds"][1]["thumbnail"]["url"] = thumbnail
    end

    if image then
        PlayerData["embeds"][1]["image"]["url"] = image
    end

    function embed:SetFooter(args)
        local text = args.Text
        local iconurl = args.IconURL

        if text then
            PlayerData["embeds"][1]["footer"]["text"] = text
        end

        if iconurl and text then
            PlayerData["embeds"][1]["footer"]["icon_url"] = iconurl
        end
    end

    function embed:SetAuthor(args)
        local name = args.Name
        local url = args.Url
        local icon_url = args.IconURL

        if name then
            PlayerData["embeds"][1]["author"]["name"] = name
        end

        if url and name then
            PlayerData["embeds"][1]["author"]["url"] = url
        end

        if name and icon_url then
            PlayerData["embeds"][1]["author"]["icon_url"] = icon_url
        end
    end

    function embed:AddField(args)
        local name = args.Name
        local value = args.Value
        local inline = args.Inline

        table.insert(PlayerData["embeds"][1]["fields"], {
            ["name"] = name,
            ["value"] = value,
            ["inline"] = inline
        })
    end


    function embed:Send()
        local PlayerData = game:GetService('HttpService'):JSONEncode(PlayerData)
        http_request({Url=Library.Webhook, Body=PlayerData, Method="POST", Headers=Headers})
    end

    return embed
end

return Library
