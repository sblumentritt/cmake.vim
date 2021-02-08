local compe = require("compe")
local Source = {}

function Source.new()
    return setmetatable({}, { __index = Source })
end

function Source.get_metadata(self)
    return {
        priority = 3,
        menu = "[cmake]",
        filetypes = {"cmake"}
    }
end

function Source.determine(self, context)
  return compe.helper.determine(context)
end


function Source.complete(self, context)
    local commands = vim.api.nvim_call_function('cmake#gather_candidates', {'command'})
    local variables = vim.api.nvim_call_function('cmake#gather_candidates', {'variable'})
    local properties = vim.api.nvim_call_function('cmake#gather_candidates', {'property'})

    local function table_concat(src, dest)
        for k,v in pairs(src) do
            table.insert(dest, v)
        end
        return dest
    end

    local complete_items = {}

    complete_items = table_concat(commands, complete_items)
    complete_items = table_concat(variables, complete_items)
    complete_items = table_concat(properties, complete_items)

    context.callback({items = complete_items})
end

return Source.new()
