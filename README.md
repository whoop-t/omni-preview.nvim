# Omni-Preview.nvim

Provides a master list of nvim preview plugins for different filetypes and a
command to tie them together. Providesane defaults and gets everything working
quickly. 



https://github.com/user-attachments/assets/d6ec4edc-d085-4b73-8388-e5e126e7f681




> [!IMPORTANT]
> Still in early stages and lacking support for many plugins, PR's to support your plugin are super welcome! I'll try to add as many as I can.

**Builtin**: 
- [x] Simple files: `.png`, `.svg`, `.tiff`, `.jpeg`, `.html`, `.pdfs`, etc. 

**Works out of the box with third party** 
- [x] CSV 
- [ ] Latex
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
Simply installing plugins as dependencies should be enough to make them work out of the box. Omnilist knows how to start most preview plugins.  

**For example with** `Lazy`

```lua 
{
    "sylvanfranklin/omni-preview",
    dependencies = {
        { 'chomosuke/typst-preview.nvim', lazy = true },                                         -- typst
        { 'hat0uma/csvview.nvim',         lazy = true },                                         -- csv
    },
    opts = {},
}
```
**Override default settings**
Sometimes these plugins have behavior that you want to change, simply call setup on them yourself.  

```lua
{
    "sylvanfranklin/omni-preview",
    dependencies = {
        { "toppair/peek.nvim",            lazy = true, build = "deno task --quiet build:fast" } -- markdown
    },
    config = function()
        require("omni-preview").setup()
        require("peek").setup({ app = "browser" })
    end
}
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
- [ ] More config options for more plugins
