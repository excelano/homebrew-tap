# Excelano Homebrew Tap

Homebrew formulae for [Excelano](https://excelano.com)'s command-line tools, for
macOS and Linux.

## Usage

```sh
brew tap excelano/tap
brew trust excelano/tap   # one-time: Homebrew gates third-party taps behind explicit trust
brew install xql
```

Upgrade alongside everything else with `brew upgrade`.

## Formulae

| Tool | Description |
| --- | --- |
| [xql](https://excelano.com/xql/) | Run real SQL against SharePoint Lists and CSV files |
| [nved](https://excelano.com/nved/) | Terminal text editor that edits in your scrollback like a REPL |
| [ved](https://excelano.com/ved/) | The verbose `ed` — a drop-in `ed` clone with friendly errors |
| [xled](https://excelano.com/xled/) | `sed` and `awk` for tabular data over CSV/DSV |
| [paxc](https://excelano.com/paxc/) | Compiler for the pax DSL → Power Automate cloud flows |
| [blick](https://excelano.com/blick-cli/) | Check Microsoft 365 mail, Teams, and next meeting from the terminal |
| [xftp](https://excelano.com/xftp/) | FTP-style interactive client for SharePoint document libraries |
| [xcp](https://excelano.com/xftp/) | Copy files to and from SharePoint, like `cp` |
| [xfind](https://excelano.com/xftp/) | Find files in SharePoint document libraries, like `find` |
| [xtree](https://excelano.com/xftp/) | Show SharePoint document libraries as a tree, like `tree` |
| [xsync](https://excelano.com/xftp/) | Sync local directories with SharePoint document libraries |

Each formula pulls the prebuilt release binary for your platform; nothing is
compiled locally. The same tools are also available as Debian packages from the
[Excelano apt repository](https://excelano.com/apt/) and via each project's own
installer.

## License

This tap's metadata is MIT-licensed. Each tool carries its own license (all MIT);
see the individual repositories under [github.com/excelano](https://github.com/excelano).
