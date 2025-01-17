# Omni Preview 
Lightweight and extensible neovim plugin to manage previews for different filetypes. This plugin provides a few of the simplest builtin previews, but generally aims to outsource complex or live previews to other plugins. OmniPreview aims to keep track of the most common preview plugins in the neovim ecosystem and provide simple configuration defaults to get them working quickly.

**Builtin**: 
- [x] Simple files: `.png`, `.svg`, `.tiff`, `.jpeg`, `.html`, `.pdfs`, etc. 
- [x] Frontend web servers (`node`, `deno`, `bun`) _Port is currently hardcoded_

**Works out of the box with third party** 
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
  config = function()
    require 'omni-preview'.setup {}
  end,
}
```

### Installing Previews
Simply installing most preview plugins should be enough to make them work out of the box. OmniPreview will auto setup most preview plugins with sensible defaults. For a full list and the ability to override see TODO 

**For example with** `Lazy`

```lua 
    { "toppair/peek.nvim",            lazy = true }, -- markdown
    { 'chomosuke/typst-preview.nvim', lazy = true }, -- typst
    { 'hat0uma/csvview.nvim',         lazy = true }, -- csv
    -- etc
```

## Usage
`:OmniPreviewStart`, `:OmniPreviewStop`, `:OmniPreviewToggle`. 

There is no default keymapping, I recommend setting: 

```lua
vim.keymap.set("n", "<leader>p", ":OmniPreviewToggle<CR>", { silent = true })
```


#### ROADMAP 🌾
Lot's of work to do, this is early days. 

- [ ] Mason like UI and registry. 
- [ ] Telescope like picker to support multiple types of previews
