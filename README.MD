Vim Configuration
========================

This is my own configuration for vim. So far I'm not using any plugin manager, as I believe they add too much
clutter to my configuration, and I don't want to be in the cutting edge with my vim.

Plugins Used
------------------------

The plugins that I currently use


Keyboard Shortcuts
------------------------

### General

| Command | Shortcut | Description |
| ------- | -------- | ----------- |
| NERDTree Toggle | `,t` | Show/hide NERDTree |
| Hidden chars Toggle | `,l` | Show/hide spaces/tabs/cr |
| Paste mode Toggle | `,P` | Enable/disable paste mode to avoid auto-formatting |
| Signify | `,s` | Show Git changes with Signify |
| Line numbers | `,m` | Show/hide line numbers |
| Relative numbers | `,m` | Toggle between absolute and relative numbers |
| Syntastic | `,r` | Toggle Syntastic to run on buffer write or not |

### Within NERDTree
| Command | Shortcut | Description |
| ------- | -------- | ----------- |
| Open file | `o` | Open file in new buffer |
| Quit | `q` | Quite NERDTree |
| Help | `h` | Show NERDTree help |

### Ctrl-P
| Command | Shortcut | Description |
| ------- | -------- | ----------- |
| Find file | `,pp` | Opens CtrlP find file window |
| Find in buffer | `,pb` | Opens CtrlP to find in buffer |
| Find in MRU | `,pr` | Opens CtrlP to find in MRUs |
| Find in Mixed | `,pa` | Opens CtrlP to find in MRU, buffer or file |

### Comments
| Command | Shortcut | Description |
| ------- | -------- | ----------- |
| Comment |`,cc` | Comment line or block if in visual |
| Uncomment | `,cx` | Uncomment line or block if in visual |

### Buffers instead of tabs
| Command | Shortcut | Description |
| ------- | -------- | ----------- |
| New | `,bc` | New buffer |
| Previous | `,bp` | Previous buffer |
| Next | `,bn` | Next buffer |
| Quit | `,q` | Close current buffer |

### Fugitive
| Command | Shortcut | Description |
| ------- | -------- | ----------- |
| Status | `,gs` | git status |
| Diff | `,gd` | git diff |
| Commit | `,gc` | git commit |

### Movement
| Shortcut | Command |
| -------- | ------- |
| `h` | move one character left |
| `j` | move one row down |
| `k` | move one row up |
| `l` | move one character right |
| `w` | move to beginning of next word |
| `b` | move to previous beginning of word |
| `e` | move to end of word |
| `W` | move to beginning of next word after a whitespace |
| `B` | move to beginning of previous word before a whitespace |
| `E` | move to end of word before a whitespace |
| `0` | move to beginning of line |
| `$` | move to end of line |
| `^` | move to first non-blank char of the line |
| `_` | same as above, but can take a count to go to a different line |
| `g_` | move to last non-blank char of the line (can also take a count as above) |
| `gg` | move to first line |
| `G` | move to last line |
| `nG` | move to n'th line of file (where n is a number) |
| `H` | move to top of screen |
| `M` | move to middle of screen |
| `L` | move to bottom of screen |
| `z.` | put the line with the cursor at the center |
| `zt` | put the line with the cursor at the top |
| `zb` | put the line with the cursor at the bottom of the screen |
| `Ctrl-D` | move half-page down |
| `Ctrl-U` | move half-page up |
| `Ctrl-B` | page up |
| `Ctrl-F` | page down |
| `Ctrl-o` | jump to last cursor position |
| `Ctrl-i` | jump to next cursor position |
| `n` | next matching search pattern |
| `N` | previous matching search pattern |
| `*` | next whole word under cursor |
| `#` | previous whole word under cursor |
| `g*` | next matching search (not whole word) pattern under cursor |
| `g#` | previous matching search (not whole word) pattern under cursor |
| `%` | jump to matching bracket { } [ ] ( ) |
