If you ever want to blow away all the plugins + `./lazy-lock.json` to reinstall the latest of everything:

```sh
rm -rf ~/.local/share/nvim
```

Then eveything should re-install once you open `nvim` the next time.

## Plugin I've tried and aren't for me

This purpose of this section is so I don't continue to see these plugins as shiny things to try when I already have

- [mini-files.nvim](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-files.md)
  - It certainly looks nice how it can appear on top of existing buffers.
  - But because there's no way to open buffers with this, it's just a pure competitor to oil.nvim for me
  - Given this, I prefer oil for my taste because I like that it goes full screen so I'm full into my file operations
- [folke/trouble.nvim](https://github.com/folke/trouble.nvim)
  - I hoped that similar to folk's TODO plugin, that this would magically be able to show me all the diagnostics for the project. Alas, that was too much to expect and would probably not be performant
  - However, given the same diagnostics functionality as Telescope, I don't dislike seeing them in a quickfix list vs a Telescope window, but I'm not sure that makes a big enough difference to go with this over Telescope
  - The symbol browser is way better than the Telescope one and I would totally use this plugin just for this symbol view! Unfortunately, I can get it to a usable state and after reading the source code for the plugin, I don't think it's customizable enough
  - It looks like the only styling / position options for how to show anything with Trouble are listed [here](https://github.com/folke/trouble.nvim/blob/main/lua/trouble/command.lua#L57), which are quite limited. I tried every combination I can think of and it's all unusable.
  - I like this symbols viewer enough that I'm keeping the plugin file around and just disabling the plugin in hopes that one day I can achieve what want
  - TODO: Check to see if this plugin has been update with more customizability
- [kungfusheep/snipe-lsp.nvim](https://github.com/kungfusheep/snipe-lsp.nvim)
  - Seems pretty nice, but the results that show up in the menu are much fewer than appear with Trouble or Telescope
- [catgoose/telescope-helpgrep.nvim](https://github.com/catgoose/telescope-helpgrep.nvim)
  - I was excited by this one because I would prefer this over using the Snacks picker for searching help pages
  - Unfortunately, the search results here are far inferior to the Snacks picker so I'll have to go back to Snacks
- [karb94/neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) or Snacks.scroll
  - These smooth scrolling plugins always seem nice but after trying them out, they end up making things feel a bit less instant due to the animation. Oh well!

# Old README

If you ever run into any issues such as "nvim-tree.renderer.help not found", try this:

Enter this in command mode to show you the path to

```
= vim.fn.stdpath('data')
```

cd in there and `rm -rf` this directory `site/pack/packer/`

This would happen if you used to have the old packer setup installed. Those files could cause issues.

Got this from here:
https://old.reddit.com/r/neovim/comments/1640z3m/nvimtree_breaks_with_theme_change/
