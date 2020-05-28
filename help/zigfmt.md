# Zig Fmt Plugin

To run `zig fmt` on the current file:

```
> zigfmt
```

To run `zig fmt --check` on the current file (using the linter plugin):

```
> lint
```

To automatically run these when you save the file, use the following
options:

* `zigfmt.fmt`: run `zig fmt` on file saved (will not report parse errors). Default value: `on`
* `zigfmt.lint`: enable `zig fmt --check` integration with the linter plugin. Default value: `on`
