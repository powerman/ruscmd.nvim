# ruscmd.nvim

## About

Neovim plugin to use NORMAL and CMDLINE modes with Russian keyboard layout.

With this plugin you can avoid switching between Russian/English keyboard layouts
when you need to enter:

- almost any command in NORMAL mode;
- frequently used (it's configurable) command in Command-line mode.

## Features

- Supported Russian keyboard layouts: ЙЦУКЕН.

- Support all NORMAL mode keys except (keys are shown in English layout):

  | Key       | English layout                                       | Russian layout                                         |
  | --------- | ---------------------------------------------------- | ------------------------------------------------------ |
  | Shift-`\` | `\|` - to screen column \[count] in the current line | `/` - search forward                                   |
  | `/`       | `/` - **search forward**                             | `.` - **repeat last change**                           |
  | Shift-`/` | `?` - search backward                                | `,` - repeat latest f, t, F or T in opposite direction |
  | Shift-`2` | `@` - execute the contents of register               | `"` - use {register} for next delete, yank or put      |
  | Shift-`4` | `$` - to the end of the line                         | `;` - repeat latest f, t, F or T \[count] times        |
  | Shift-`6` | `^` - to the first non-blank character of the line   | `:` - command-line mode                                |
  | Shift-`7` | `&` - repeat last substitute                         | `?` - search backward                                  |

- Command-line mode commands supported by default:
  - `bd`
  - `bn`
  - `q`
  - `qa`
  - `w`
  - `wq`
  - `wqa`

## Installation

Install the plugin with your preferred package manager:

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "powerman/ruscmd.nvim",
  opts = {
      -- Your configuration here, if any.
  },
}
```

## Setup

You should call `setup()` to start using the plugin (package managers configured as shown
above will do this for you).

```lua
require('ruscmd').setup {
    -- Your configuration here, if any.
}
```

## Configuration

```lua
{
  -- Setup command-line mode abbreviations.
  cabbrev = {
      -- Add extra commands:
      ['ефитуц'] = 'tabnew',
      ['Дфян'] = 'Lazy',
      -- Disable default commands by redefining them:
      ['ив'] = 'ив', -- default: bd
  },
}
```

## Usage

Just do not switch from Russian to English keyboard layout in most cases.

## See also

Similar plugin for Vim: <https://github.com/powerman/vim-plugin-ruscmd>.
