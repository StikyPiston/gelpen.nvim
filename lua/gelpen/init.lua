local M = {}
local api = vim.api
local fn = vim.fn

M.config = {
    wiki_path = nil,
}

-- Setup function
M.setup = function(opts)
    M.config = vim.tbl_extend("force", M.config, opts or {})
end

-- Ensure directory exists
local function ensure_dir(path)
    if not io.open(path, "r") then
		fn.mkdir(path)
    end
end

-- Open or create index.md
M.open_index = function()
    local wiki = M.config.wiki_path
    if not wiki then
        vim.notify("Gelpen: wiki_path not set!", vim.log.levels.ERROR)
        return
    end

    ensure_dir(wiki)

    local index = wiki .. "/index.md"

    if fn.filereadable(index) == 0 then
        -- create empty file
        fn.writefile({}, index)
    end

    vim.cmd("edit " .. index)
end

-- Extract [[link]] on current line
local function find_link()
    local line = api.nvim_get_current_line()
    local link = line:match("%[%[(.-)%]%]")
    return link
end

-- Create the file for link if needed, open it
M.follow_link = function()
    local wiki = M.config.wiki_path
    local raw = find_link()
    if not raw then return end

    -- full filesystem path
    local filepath = wiki .. "/" .. raw

    -- ensure directories exist
    local dir = fn.fnamemodify(filepath, ":h")
    ensure_dir(dir)

    -- ensure file exists
    if fn.filereadable(filepath) == 0 then
        fn.writefile({}, filepath)
    end

    -- open file
    vim.cmd("edit " .. filepath)
end

-- Create user command
api.nvim_create_user_command("Gelpen", function()
    M.open_index()
end, {})

-- Keymap for pressing enter on a link
-- (User can override in real configs; included here for convenience)
vim.keymap.set("n", "<CR>", function()
    local link = find_link()
    if link then
        M.follow_link()
    else
        return "<CR>"
    end
end, {expr=true})

return M

