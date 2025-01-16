# Omni Preview 
Lightweight and highly extensible plugin to manage previews for different filetypes. This plugin provides a few of the simplest builtin previews, but generally aims to outsource complex or live previews to other plugins. This repository is more documentation than plugin, with a simple set of functions to glue everything together.

**Works out of the box**: 
- [x] Images Formats: `.png`, `.svg`, `.tiff`, `.jpeg`, `.html`, `.pdfs`
- [x] Frontend web servers (`node`, `deno`, `bun`) _Port is currently hardcoded_

**Easy with third party plugins** 
- [x] CSV 
- [x] Latex
- [x] Markdown
- [x] Typst
- [ ] ...More coming soon

## Install

`Lazy.nvim`

```lua
{
    "sylvanfranklin/omni-preview.nvim",
    opts = {}
}
```
`Packer.nvim` 

```lua
use {
  'sylvanfranklin/omni-preview.nvim',
  tag = 'v1.*',
  config = function()
    require 'omni-preview'.setup {}
  end,
}
```

## Configure


#### ROADMAP 🌾
One day I would love to make this plugin behave like `mason.nvim` with a ui list of preview plugins that can be installed from the ui. That will require a dive into Mason and how it's registry works. 

- [ ] Ability to toggle all previews on and off.
- [ ] Mason like UI. 
