lusty-mustache
==============

mustache rendering for lusty

```lua
local config = {
  render = {
    { ['lusty-mustache.render.mustache'] = {
        -- set defaults here
        template {
          name = 'templates/layout',

          partials = {
            content = 'templates/home'
          }
        }
    } }
  }
}
```
