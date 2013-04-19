local lustache = require "lustache"
local cache = {}

local readAll = function(file)
  local f = io.open(file, "rb")
  content = f:read("*all")
  f:close()

  return content
end

local getFile = function(file, cache)
  local content = cache[file]

  if not content then
    content = readAll(file)
    content = lustache:compile(content)
    cache[file] = content
  end

  return content
end

return {
  handler = function(context)
    context.response.headers["content-type"] = "text/html"

    local partials = {}
    local template = getFile(context.template.name..'.mustache', cache)

    for i,v in pairs(config.partials) do
      partials[i] = getFile(v..'.mustache', cache)
    end

    lustache.renderer.partial_cache = partials
    local content = template(context.output)

    context.response.send(content)
  end,

  options = {
    predicate = function(context)
      return context.template.type == "mustache"
    end
  }
}

