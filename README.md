<div align="center">
    <img width="446" height="106" alt="preview" src="https://raw.githubusercontent.com/maarutan/moonlight.nvim/main/assets/preview.png" />
</div>

<p align="center">
  A fast, modern and beautiful Neovim IDE.
</p>

<hr>

<h4 align="center">
  <a href="#-getting-started">Install</a>
  ·
  <a href="#-requirements">Dependencies</a>
  ·
  <a href="#-screenshots">Screenshots</a>
</h4>

<div align="center"><p>
    <a href="https://github.com/maarutan/moonlight.nvim/pulse">
      <img alt="Last commit" src="https://img.shields.io/github/last-commit/maarutan/moonlight.nvim?style=for-the-badge&logo=starship&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/maarutan/moonlight.nvim/blob/main/LICENSE">
      <img alt="License" src="https://img.shields.io/github/license/maarutan/moonlight.nvim?style=for-the-badge&logo=starship&color=ee999f&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/maarutan/moonlight.nvim/stargazers">
      <img alt="Stars" src="https://img.shields.io/github/stars/maarutan/moonlight.nvim?style=for-the-badge&logo=starship&color=c69ff5&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/maarutan/moonlight.nvim/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/maarutan/moonlight.nvim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/maarutan/moonlight.nvim">
      <img alt="Repo Size" src="https://img.shields.io/github/repo-size/maarutan/moonlight.nvim?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://neovim.io">
        <img alt="Neovim" src="https://img.shields.io/badge/Neovim-0.11+-8bd5ca?style=for-the-badge&logo=neovim&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://www.lua.org">
        <img alt="Lua" src="https://img.shields.io/badge/Lua-config-c69ff5?style=for-the-badge&logo=lua&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://wakatime.com/badge/user/e49eaebf-2429-4aa4-919b-670e8ef6be5c/project/51d62c9b-ad58-4613-86e2-46e1c2a8a606">
        <img src="https://wakatime.com/badge/user/e49eaebf-2429-4aa4-919b-670e8ef6be5c/project/51d62c9b-ad58-4613-86e2-46e1c2a8a606.svg" alt="wakatime">
    </a>
</p></div>

---

moonlight.nvim is a modern, full-featured Neovim IDE built on top of [💤 lazy.nvim](https://github.com/folke/lazy.nvim),
focused on performance, clean UI/UX, and developer productivity.

It provides a powerful plugin ecosystem, carefully selected defaults, and an optimized configuration,
so you can start coding immediately without sacrificing flexibility.

Instead of choosing between a minimal setup or a heavy distro,
moonlight.nvim delivers the perfect balance — fast, extensible, and ready out of the box.

---

## ✨ Features

- ⚡ Fast startup powered by lazy.nvim
- 🧠 Full LSP support out of the box
- 🎨 Clean and modern UI
- 📦 Rich plugin ecosystem
- 🔧 Easy to extend and customize

---

## 📸 Screenshots

<p align="center">
  <img width="100%" src="https://raw.githubusercontent.com/maarutan/moonlight.nvim/main/assets/screenshot1.png" />
  <img width="100%" src="https://raw.githubusercontent.com/maarutan/moonlight.nvim/main/assets/screenshot2.png" />
</p>

---

## ⚡️ Requirements

- Neovim >= **0.11.2** (built with **LuaJIT**)
- Git >= **2.19.0**
- a [Nerd Font](https://www.nerdfonts.com/) _(optional)_
- a **C** compiler for `nvim-treesitter`

---

## 🚀 Getting Started

<details><summary>Install moonlight.nvim</summary>

### Backup your current config

```sh
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

### Clone repository

```sh
git clone --depth 1 https://github.com/maarutan/moonlight.nvim ~/.config/nvim
```

### Remove git history (optional)

```sh
rm -rf ~/.config/nvim/.git
```

### Start Neovim

```sh
nvim
```

</details>

---

⭐ If you like this project, consider giving it a star!
