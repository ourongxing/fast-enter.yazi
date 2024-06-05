# fast-enter.yazi

Plugin for [Yazi](https://github.com/sxyazi/yazi) to enter the sub folder faster, or open the file directly.

With more features:
- Auto decompress archives and enter it. 
- Go directly to the innermost folder, if there is always only one sub folder

To install, clone the repo inside your `~/.config/yazi/plugins/`:

```bash
git clone https://github.com/ourongxing/fast-enter.yazi.git
```

Then bind it for `l` key, in your `keymap.toml`:

```toml
[[manager.prepend_keymap]]
on   = [ "l" ]
run  = "plugin --sync fast-enter"
desc = "Enter the sub folder faster, or open the file directly"
```
