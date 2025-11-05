# Todo

## P1

- [ ] Add modes highlight namespaces for each category (2 * 2 * 4 namespaces)
- [ ] Add winbar specific values for the highlight presets

## On light/dark mode switch
-- I don't consider the case lots of windows exist
-- if so, nvim_set_hl_ns() once, and nvim_win_set_hl_ns() for active window will be faster
local list_wins = vim.api.nvim_list_wins()
if #list_wins == 0 then
    -- Case 3: No windows exist. Error handling
elseif #list_wins == 1 then
    -- Case 1: Only one window exists.
    vim.api.nvim_win_set_hl_ns(0, current_ns_id)
else
    -- Case 2: Two, three, or more windows exist.
    -- (You're assuming small numbers where this is faster)
    local all_wins = list_wins
    local current_win_id = vim.api.nvim_get_current_win()
    local non_current_wins = all_wins - current_win_id
    for _, win_id in ipairs(non_current_wins) do
        vim.api.nvim_win_set_hl_ns(win_id, non_current_ns_id)
    end
    vim.api.nvim_win_set_hl_ns(current_win_id, current_ns_id)
end

## P2

- [ ] Consider not by triggered by InsertLeave, but textchanged + debouncing (it might be faster?) like this applies to auto-save, linting, and formatting
- [ ] Debounce overall

## P3
- [ ] LSP keymaps: go to definition, references, etc.
- [ ] Configure diagnostics appearance
- [ ] Learn: quickfix, jumplist, vim marks
- [ ] Winbar: word count in markdown files
- [ ] Learn: nvim-surround usage
