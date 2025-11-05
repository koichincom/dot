local M = {}

local file_path = nil
local file_name = nil
local last_full_path = nil
function M.get_path_name(params)
    local full_path = vim.fs.normalize(vim.fn.expand "%:p")
    if full_path == last_full_path then
        return nil, false
    end
    last_full_path = full_path
    file_path, file_name = "", ""

    -- Handle oil.nvim directory buffers (display directory path only, no filename)
    if vim.startswith(full_path, "oil:/") or full_path == "oil:" then
        full_path = vim.fs.normalize(require("oil").get_current_dir())
        if full_path ~= vim.fs.normalize(vim.fn.getcwd()) then
            file_path = vim.fn.fnamemodify(full_path, ":.")
        end
    else
        -- Normal file buffers: split into directory and filename
        full_path = vim.fn.fnamemodify(full_path, ":.") -- Make relative to cwd
        file_path = vim.fn.fnamemodify(full_path, ":h") -- Directory portion
        file_path = file_path:gsub("^%.$", "")          -- Remove "." for cwd root
        file_name = vim.fn.fnamemodify(full_path, ":t") -- Filename only
    end

    -- Normalize display: strip leading/trailing slashes
    if string.sub(file_path, 1, 1) == "/" then
        file_path = string.sub(file_path, 2, #file_path)
    end
    if string.sub(file_path, #file_path, #file_path) == "/" then
        file_path = string.sub(file_path, 1, #file_path - 1)
    end

    if string.sub(file_name, 1, 1) == "/" then
        file_name = string.sub(file_name, 2, #file_name)
    end
    if string.sub(file_name, #file_name, #file_name) == "/" then
        file_name = string.sub(file_name, 1, #file_name - 1)
    end
    return { file_path = file_path, name = file_name }, true
end

local last_encode = nil
function M.get_encode(params)
    local encode = (vim.bo.fileencoding or ""):lower()
    if encode ~= "utf-8" and encode ~= "" then
        encode = "[" .. encode .. "]"
    else
        encode = ""
    end
    if encode ~= last_encode then
        last_encode = encode
        return encode, true
    else
        return nil, false
    end
end

return M
