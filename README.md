micro-zigfmt
============

Plugin for the [micro editor](https://github.com/zyedidia/micro) that provides support for:

- `zig fmt` on save
- `zig fmt --check` integration with the official linter plugin

for [Zig](https://github.com/ziglang/zig) files.

## Installation

Using the plugin manager:

```
micro -plugin install zigfmt
```

Or from within micro (must restart micro afterwards for the plugin to be loaded):

```
> plugin install zigfmt
```

Or manually install by cloning this repo as `zigfmt` into your `plug` directory:

```
git clone https://github.com/squeek502/micro-zigfmt ~/.config/micro/plug/zigfmt
```

## Usage

See [the help file](help/zigfmt.md)

Or, after installation, from within micro:

```
> help zigfmt
```
