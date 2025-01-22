# Omni-Preview.nvim

Provides a master list of nvim preview plugins for different filetypes and a
command to tie them together. The goal is to get everything working quickly, while keeping open advanced configuration.


https://github.com/user-attachments/assets/e9c0a587-0536-478d-b408-30422ac8e73b



> [!IMPORTANT]
> Still in early stages and lacking support for many plugins, PR's to support your plugin are super welcome! I'll try to add as many as I can.

**Builtin**: 
- [x] Simple files: `.png`, `.svg`, `.tiff`, `.jpeg`, `.html`, `.pdfs`, etc. 

**Works out of the box with third party** 
- [x] CSV 
- [x] Latex (just by finding a corresponding pdf file, look into vimtex for more)
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
Simply installing plugins as dependencies calls `.setup` which is usually enough for most of these pugins to work. If for some reason it doesn't you can manually call `.setup()` on each of them. 

**For example with** `Lazy`

```lua 
{
    "sylvanfranklin/omni-preview",
    dependencies = {
        -- Typst
        { 'chomosuke/typst-preview.nvim', lazy = true },
        -- CSV
        { 'hat0uma/csvview.nvim',         lazy = true },
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
        -- for markdown
        { "toppair/peek.nvim", lazy = true, build = "deno task --quiet build:fast" } 
    },
    config = function()
        require("omni-preview").setup()
        require("peek").setup({ app = "browser" })
    end
}
```

## Usage
`:OmniPreviewStart`, `:OmniPreviewStop`, `:OmniPreviewToggle`. 

There is no default keymapping for the, I recommend setting: 

```lua
vim.keymap.set("n", "<leader>p", ":OmniPreviewStart<CR>", { silent = true })
```

I often just close the preview manually since some of them don't have defined stop behavior, for instance system level preview tools.  

## Filetypes

Remember to add these as dependencies or set them up manually with `.setup`


#### Typst


- [typst-preview.nvim](https://github.com/chomosuke/typst-preview.nvim) Instant onpyte updating preview  

```lua
{ 'chomosuke/typst-preview.nvim', lazy = true }, 
```


#### Markdown

- [peek.nvim](https://github.com/toppair/peek.nvim) Best all around in my experience.

```lua 
{ "toppair/peek.nvim", lazy = true, build = "deno task --quiet build:fast" },
```

- [mardown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) Slightly older but still great.

```lua
{"iamcco/markdown-preview.nvim", lazy = true}
```
- [markview.nvim](https://github.com/OXY2DEV/markview.nvim) In editor conceal based preview (also requires treesitter and dev icons)
```lua
{ "OXY2DEV/markview.nvim", lazy = true}
```

#### CSV

- [csvview.nvim](https://github.com/hat0uma/csvview.nvim) Conceal in editor

```lua
{ 'hat0uma/csvview.nvim', lazy = true } 
```

#### Other
For images and other types I just use the unix `open` command. You can override that behavior by passing a filetype and start and stop string or function.

```lua
require("omni-preview").setup({
    previews = {
        { trig = "pdf", start = "zathura" -- , stop=... }
    }
})
```

#### ROADMAP 🌾
Lot's of work to do, this is early days. 
- [ ] Mason like UI and registry
- [ ] Telescope like picker to support multiple types of previews
- [ ] More config options for more plugins
- [ ] More advanced support for LaTeX 
- [ ] Support for multiple previews on a single filetype
