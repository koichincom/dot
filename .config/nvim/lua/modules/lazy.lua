-- Lazy.nvim initialization
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then -- if not found, clone it
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    }
    -- if cloning fails, raise an error and stop
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end

vim.opt.runtimepath:prepend(lazypath)
local lazy = require "lazy"
return lazy
