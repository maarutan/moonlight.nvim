## M O O N L I G H T 🌙

```text
--                             M O O N L I G H T.nvim
--       _..._         _..._         _..._         _..._         _..._
--     .:::::::.     .::::. `.     .::::  `.     .::'   `.     .'     `.
--    :::::::::::   :::::::.  :   ::::::    :   :::       :   :         :
--    :::::::::::   ::::::::  :   ::::::    :   :::       :   :         :
--    `:::::::::'   `::::::' .'   `:::::   .'   `::.     .'   `.       .'
--      `':::''       `'::'-'       `'::.-'       `':..-'       `-...-'
--
--------------------------------------------------------------------->
--              ┌┬┐ ┌─┐ ┌─┐ ┌┐┌  ┬   ┬ ┌─┐ ┬ ┬ ┌┬┐                Z
--              │││ │ │ │ │ │││  │   │ │ ┌ ┬─┼  │              Z
--              ┴ ┴ └─┬ └─┬ ┘└┘  ┴─┬ ┴ └─┬ ┴ ┬  ┴ .nvim   z
--------------------------------------------------------------------->
```

## 🗂 Map list

- [Description 📝](#-description)
  - [Requirements 📦](#-requirements)

- [Screenshots 📷](#-screenshots)
  - [Dashboard](#-screenshots-dashboard)
  - [Python](#-screenshots-python)

- [If you use `Kitty`](#-kitty-terminal)
  - [`Kitty` Keymaps](#-keymaps)

- [All Keymaps](#-all-keymaps--luapluginswhich_keylua)

## 📝 Description

> **Moonlight.nvim** is a custom Neovim configuration focused on productivity and maximum comfort.
> Written entirely in **Lua**, it follows a **declarative setup** using the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.
>
> Designed to feel like a full-featured **IDE**, Moonlight.nvim balances minimalism and power.
> LSP and tooling (formatter, linter, etc.) are **disabled by default** and can be enabled declaratively.
>
> To initialize tools, simply run:
>
> ```vim
> :MasonToolsUpdate
> ```
>
> Explore `lua/dev/mason` to manage your LSP, linters, and formatters declaratively.
> Check [Requirements 📦](#-requirements)

## 📦 Requirements

> **Linux 🐧:**
> `neovim` `bash` `coreutils` `curl` `git` `gcc` `make` `zip` `unzip` `go` `lua` `luarocks` `python` `python-pip` `nodejs` `npm` `cargo` `ripgrep` `fd` `tree-sitter` `imagemagick` `trash-cli`

#### Arch Linux

```bash
sudo pacman -Sy neovim bash coreutils curl git gcc make zip unzip go lua luarocks python python-pip nodejs npm cargo ripgrep fd tree-sitter imagemagick trash-cli
```

> **MacOS 🍎:**
> `neovim` `bash` `coreutils` `curl` `git` `gcc` `make` `zip` `unzip` `go` `lua` `luarocks` `python` `python-pip` `nodejs` `npm` `cargo` `ripgrep` `fd` `tree-sitter` `imagemagick`

#### Homebrew

```zsh
brew install neovim bash coreutils curl git gcc make zip unzip go lua luarocks python node rust ripgrep fd tree-sitter-cli imagemagick
```

---

## 😽 Kitty Terminal

> The **Moonlight.nvim** setup is designed for the **Kitty terminal**. It supports inline image previews and advanced copy functionality through `kitty-scrollback.nvim`, as well as dynamic font and layout synchronization via `kitty-lock.json`.
>
> **Kitty is strongly recommended** for the full Moonlight.nvim experience.
>
> If you want to configure `kitty_tern` for font control, navigate to:
>
> `lua/plugins/tools/kitty_term/config`
>
> There you'll see:
>
> ```lua
> M.setup = {
>   config_path = "kitty-lock.json",
>   kitty_path  = "~/.config/kitty/font.cfg",
> }
> ```
>
> - `config_path` — path to `kitty-lock.json` starting from your `nvim/` directory.
> - `kitty_path` — path to your Kitty configuration file containing font settings.
>
> ### ⌨️ Keymaps
>
> - `<leader>ku` — Kitty Font +1
> - `<leader>kd` — Kitty Font -1
> - `<leader>kf` — Kitty Font Picker
> - `<leader>ks` — Kitty Size Picker
> - `<leader>kr` — Kitty Reload Config
> - `<leader>ki` — Kitty Status Config

---

#### ⌨️ All Keymaps

> - [`lua/plugins/which_key.lua`](./lua/plugins/which_key.lua)

---

## 📷 Screenshots

| Dashboard                                                                                                                 | Python                                                                                                                 |
| ------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| <img width="500" alt="dashboard" src="https://github.com/user-attachments/assets/4888458f-91f0-47b5-9455-02627d9d9d4c" /> | <img width="500" alt="python" src="https://github.com/user-attachments/assets/e4eeee6f-c12f-46c4-bdbd-33baab7b7556" /> |
