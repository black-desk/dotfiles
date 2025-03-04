-- This module provides utilities for
-- managing python versions and plugins with pyenv.

local M = {}

if not vim.env.PYENV_ROOT then
        return M
end

local shell = require('shell')

---
---Check if a python version exists.
---
---@param name string
---@return boolean
M.check_python_version = function(name)
        -- NOTE: Not using `pyenv versions` command here for better performance.
        return vim.fn.isdirectory(
                vim.env.PYENV_ROOT .. '/versions/' .. name
        ) == 1
end

---
---Install a python version.
---
---@param name string
---@return boolean
M.install_python_version = function(name)
        local _, ok = shell.run_command(
                { "pyenv", "install", name },
                "install python version " .. name .. " with pyenv",
                false
        )
        return ok
end

---
---Ensure a python version exists.
---
---@param name string
---@param install (fun():boolean)?
---@return boolean
M.ensure_python_version = function(name, install)
        if M.check_python_version(name) then
                return true
        end

        if install == nil then
                return M.install_python_version(name)
        end

        return install()
end

---
---Check if a pyenv plugin exists.
---
---@param name string
---@return boolean
M.check_plugin = function(name)
        return vim.fn.isdirectory(
                vim.env.PYENV_ROOT .. '/plugins/' .. name
        ) == 1
end

---
---Install a pyenv plugin.
---
---@param name string
---@param url string
---@return boolean
M.install_plugin = function(name, url)
        local _, ok = shell.run_command(
                { "git", "clone", url, vim.env.PYENV_ROOT .. '/plugins/' .. name },
                "install pyenv plugin " .. name .. " from " .. url,
                false
        )
        return ok
end

---
---Ensure a pyenv plugin exists.
---
---@param name string
---@param url string
---@return boolean
M.ensure_plugin = function(name, url)
        if M.check_plugin(name) then
                return true
        end
        return M.install_plugin(name, url)
end

return M
