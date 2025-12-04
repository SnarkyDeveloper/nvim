local enabled = {
    ai = true,
    misc = true,
    langs = true,
    ui = true,
    editor = true,
    git = true,
    sessions = true,
}

local imports = {}
for category, is_enabled in pairs(enabled) do
    if is_enabled then
        table.insert(imports, { import = "snarky.lazy." .. category })
    end
end

return imports
