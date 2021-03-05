> ##### :arrow_up: Hey! Want to migrate from v3.x to v4.x? Check our [**migration guide**](https://github.com/rafaelrinaldi/pure/releases/tag/v4.0.0), done with :heart

# pure [![github-ci-badge]][github-ci-link] ![fish-3]

> Pretty, minimal and fast Fish 🐟 prompt, ported from [`zsh`](https://github.com/sindresorhus/pure).

<div align=center>
  <a href="https://camo.githubusercontent.com/be014be282ef66e5c5cad19458aa61d7df6865ecbe55bcc882e0d53580f81de9/68747470733a2f2f692e696d6775722e636f6d2f424878556f68522e706e67" target=blank><img width=440 src=https://camo.githubusercontent.com/be014be282ef66e5c5cad19458aa61d7df6865ecbe55bcc882e0d53580f81de9/68747470733a2f2f692e696d6775722e636f6d2f424878556f68522e706e67 alt="Pure with dark colorscheme"></a>
  <a href="https://camo.githubusercontent.com/5934e8c1d3b5f9218d05d5e1741e23963a7803d6098236d36e586336a6c6a5b7/68747470733a2f2f692e696d6775722e636f6d2f714a646f6e716f2e706e67" target=blank><img width=440 src=https://camo.githubusercontent.com/5934e8c1d3b5f9218d05d5e1741e23963a7803d6098236d36e586336a6c6a5b7/68747470733a2f2f692e696d6775722e636f6d2f714a646f6e716f2e706e67 alt="Pure with light colorscheme"></a>
</div>

## :rocket: Install

**:warning: requirements**: fish `≥3.x`

### [Fisher](https://github.com/jorgebucaran/fisher)

```fish
fisher install pure-fish/pure
```

### Manually

Via [cURL](https://curl.haxx.se):

```sh
# Download the installer to `/tmp`
curl git.io/pure-fish --output /tmp/pure_installer.fish --location --silent
# Source and trigger the installer
source /tmp/pure_installer.fish; and install_pure
```

## Features

Fully **customizable** (colors, symbols and features):

- Excellent prompt character `❯` :
  - Change `❯` to red when previous command has failed ;
  - Start prompt with _current working directory_ 🏳️ ;
  - Compact-mode (single-line prompt) 🏳️ ;
- Display current directory tail ;
- check for new release on start 🏳️ ;
- Display _username_ and _hostname_ when in an `SSH` session ;
- Display command _duration_ when longer than `5` seconds ;
- Display `Python` _virtualenv_ when activated ;
- Display `VI` mode and custom symbol for non-insert mode 🏳️ ;
- Show system time 🏳️ ;
- Show number of running jobs 🏳️ ;
- Prefix when `root` 🏳️ ;
- Display `git` branch name 🏳️ ;
  - Display `*` when `git` repository is _dirty_ ;
  - Display `≡` when `git` repository is _stashed_ ;
  - Display `⇡` when branch is _ahead_ (commits to push) ;
  - Display `⇣` when branch is _behind_ (commits to pull) ;
- Update terminal title with _current folder_ and _command_ ;

## :paintbrush: Configuration

You can tweak `pure` behavior and color by changing [universal variables](https://fishshell.com/docs/current/tutorial.html#tut_universal) either directly in the terminal, _e.g._:

    set --universal pure_show_system_time true
    set --universal pure_color_system_time pure_color_mute

or changing the defaults in your `config.fish`, _e.g._:

    _pure_set_default pure_show_system_time false
    _pure_set_default pure_color_system_time grey --reverse

### Prompt Symbol

| Option                                 | Default | Description                                          |
| :------------------------------------- | :------ | :--------------------------------------------------- |
| **`pure_symbol_git_dirty`**            | `*`     | Repository is Dirty (uncommitted/untracked changes). |
| **`pure_symbol_git_stash`**            | `≡`     | Repository git stash status.                         |
| **`pure_symbol_git_unpulled_commits`** | `⇣`     | Branch is behind upstream (commits to pull).         |
| **`pure_symbol_git_unpushed_commits`** | `⇡`     | Branch is ahead upstream (commits to push).          |
| **`pure_symbol_prefix_root_prompt`**   | `#`     | Prefix prompt when logged in as `root`.              |
| **`pure_symbol_prompt`**               | `❯`     | Prompt symbol.                                       |
| **`pure_symbol_reverse_prompt`**       | `❮`     | VI non-insert mode symbol.                           |
| **`pure_symbol_title_bar_separator`**  | `-`     | Separator in terminal's windows title.               |

> :information_source: Need [safer `git` symbols](https://github.com/sindresorhus/pure/wiki/Customizations,-hacks-and-tweaks#safer-symbols)?

### 🔌 Features' Flags

| Option                                         | Default | Description                                                                                     |
| :--------------------------------------------- | :------ | :---------------------------------------------------------------------------------------------- |
| **`pure_begin_prompt_with_current_directory`** | `true`  | `true`: _`pwd` `git`, `SSH`, duration_.<br/>`false`: _`SSH` `pwd` `git`, duration_.             |
| **`pure_check_for_new_release`**               | `false` | `true`: check repo for new release (on every shell start)                                       |
| **`pure_enable_git`**                          | `true`  | Show info about Git repository.                                                                 |
| **`pure_enable_single_line_prompt`**           | `false` | `true`: Compact prompt as a single line                                                         |
| **`pure_reverse_prompt_symbol_in_vimode`**     | `true`  | `true`: `❮` indicate a non-insert mode.<br/>`false`: indicate vi mode with `[I]`, `[N]`, `[V]`. |
| **`pure_separate_prompt_on_error`**            | `false` | Show last command [exit code as a separate character][exit-code].                               |
| **`pure_show_jobs`**                           | `false` | Show Number of running jobs                                                                     |
| **`pure_show_prefix_root_prompt`**             | `false` | `true`: shows prompt prefix when logged in as `root`.                                           |
| **`pure_show_subsecond_command_duration`**     | `false` | Show subsecond (ex. 1.5s) in command duration.                                                  |
| **`pure_show_system_time`**                    | `false` | `true`: shows system time before the prompt symbol (as `%H:%M:%S`).                             |
| **`pure_threshold_command_duration`**          | `5`     | Show command duration when above this value (seconds).                                          |

### 🎨 Colours

> :information_source: See [`set_color`][fish-set-color] documentation for full possibilities.

> :warning: The absence of `$` sign is expected in `pure_` named colours.

| Base Color               | Inherited by                                                                                                                                                                                                                  | Default   |
| :----------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------- |
| **`pure_color_danger`**  | **`pure_color_prompt_on_error`**                                                                                                                                                                                              | `red`     |
| **`pure_color_dark`**    |                                                                                                                                                                                                                               | `black`   |
| **`pure_color_info`**    | **`pure_color_git_unpulled_commits`**<br>**`pure_color_git_unpushed_commits`**                                                                                                                                                | `cyan`    |
| **`pure_color_light`**   | **`pure_color_username_root`**                                                                                                                                                                                                | `white`   |
| **`pure_color_mute`**    | **`pure_color_git_branch`**<br>**`pure_color_git_dirty`**<br>**`pure_color_git_stash`**<br>**`pure_color_hostname`**<br>**`pure_color_at_sign`**<br>**`pure_color_username_normal`**<br>**`pure_color_virtualenv`** | `brblack` |
| **`pure_color_normal`**  | **`pure_color_jobs`**                                                                                                                                                                                                         | `normal`  |
| **`pure_color_primary`** | **`pure_color_current_directory`**                                                                                                                                                                                            | `blue`    |
| **`pure_color_success`** | **`pure_color_prompt_on_success`**                                                                                                                                                                                            | `magenta` |
| **`pure_color_warning`** | **`pure_color_command_duration`**                                                                                                                                                                                             | `yellow`  |

## :+1:  Contribute

> **requirements:** [`docker`](https://docs.docker.com/install/) (isolate from your environment)

Specify the [`FISH_VERSION`][fish-releases] you want, and the `CMD` executed by the container:

    make build-pure-on FISH_VERSION=3.1.2
    make dev-pure-on FISH_VERSION=3.1.2 CMD="fishtape tests/*.test.fish"

## :man_technologist: Maintainer

- [Édouard Lopez](https://github.com/edouard-lopez)

## :clap: Thanks

* [@andreiborisov](https://github.com/andreiborisov) for the [docker images][docker-images] ;
* [@jorgebucaran](https://github.com/jorgebucaran/) for [fishtape](https://github.com/jorgebucaran/fishtape) ;
* [@rafaelrinaldi](https://github.com/pure-fish/pure) for starting the project ;

## :classical_building: License

[MIT][MIT]

[github-ci-link]: <https://github.com/pure-fish/pure/actions> "Github CI"
[github-ci-badge]: <https://github.com/pure-fish/pure/workflows/Run%20tests%20on%20CI/badge.svg>
[fish-3]: <https://img.shields.io/badge/fish-v3-007EC7.svg?style=flat-square> "Support Fish 3"
[exit-code]: <https://github.com/sindresorhus/pure/wiki#show-exit-code-of-last-command-as-a-separate-prompt-character> "See pure-zsh wiki"
[fish-releases]: https://github.com/fish-shell/fish-shell/releases
[docker-images]: https://github.com/andreiborisov/docker-fish/
[MIT]: LICENSE.md
[fish-set-color]: https://fishshell.com/docs/current/cmds/set_color.html
