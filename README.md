If you ever run into any issues such as "nvim-tree.renderer.help not found", try this:

Enter this in command mode to show you the path to

```
= vim.fn.stdpath('data')
```

cd in there and `rm -rf` this directory `site/pack/packer/`

This would happen if you used to have the old packer setup installed. Those files could cause issues.

Got this from here:
https://old.reddit.com/r/neovim/comments/1640z3m/nvimtree_breaks_with_theme_change/
