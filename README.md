# telescope-jumps.nvim

- `jumplist` integration for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

## Installation

```lua
use {
  'nvim-telescope/telescope.nvim',
  requires = {
    {'nvim-lua/plenary.nvim'},
    {'nvim-lua/popup.nvim'},
    {'tkmpypy/telescope-jumps.nvim'}
  },
  config = function()
    require('telescope').load_extension('jumps')
  end,
}
```

## Usage

```lua
require'telescope'.extensions.jumps.jumps{}
```

or

```vim
:Telescope jumps jumps
```
