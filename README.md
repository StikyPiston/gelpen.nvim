# gelpen.nvim

**gelpen.nvim** is a *VimWiki*-like notetaking plugin for Neovim!

## Installation

### Using `vim.pack`

```lua
vim.pack.add({
    "https://github.com/StikyPiston/gelpen.nvim"
})
```

## Configuration

To configure where your wiki should be stored, use the following.
Note that the path **must be absolute**

```lua
require("gelpen").setup({
    wiki_path = "/absolute/path/to/your/wiki"
})
```

## Usage

To open your wiki index, simply run:

```vim
:Gelpen
```

This will drop you into the index. To create a new file, write the link relative to the wiki root as such in the index:

```markdown
[[Path/To/Note]]
```

Ensure that any subdirectories are already created.

Then, press **Enter** to open that file.
