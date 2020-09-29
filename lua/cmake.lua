local M = {}

function M.getCompletionItems(prefix, score_func)
    local commands = vim.api.nvim_call_function('cmake#gather_candidates', {'command'})
    local variables = vim.api.nvim_call_function('cmake#gather_candidates', {'variable'})
    local properties = vim.api.nvim_call_function('cmake#gather_candidates', {'property'})

    local complete_items = {}

    complete_items = table_concat(commands, complete_items)
    complete_items = table_concat(variables, complete_items)
    complete_items = table_concat(properties, complete_items)

    return complete_items
end

function table_concat(src, dest)
    for k,v in pairs(src) do
        table.insert(dest, v)
    end

    return dest
end

M.complete_item = {
    item = M.getCompletionItems
}

return M
