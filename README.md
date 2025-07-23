# 🚩 Terminal Minesweeper - Written in Ada
![Image of program](./example.png)

## 🛠️ Compile and Run (Linux)

To compile you'll need the gnat compiler and toolchain, as well as make. The oldest known compatible language version is Ada 2012.
```shell
# install gnat for your system
# sudo pacman -S gcc-ada
# sudo apt install gnat
git clone https://github.com/ImFstAsFckBoi/Ada-Minesweeper
cd Ada-Minesweeper
make
./mine
```

## 📥 Install
Install to the system, to be accessible in any directory.

### 😎 Arch Linux / pacman
There is a `PKGBUILD` script for Arch based distros.
```shell
curl -LO https://raw.githubusercontent.com/ImFstAsFckBoi/Ada-Minesweeper/refs/heads/master/PKGBUILD
makepkg -si # installs to /usr/local/bin
```
### 🤓 Other Linux
For other distros you will have to compile and install manually.
```shell
git clone https://github.com/ImFstAsFckBoi/Ada-Minesweeper
cd Ada-Minesweeper
make install # installs to ~/.local/bin
```

## 🕹️ Controls
<table>
    <tr>
        <th>
            <kbd>w</kbd>, <kbd>a</kbd>, <kbd>s</kbd>, <kbd>d</kbd>
            or
            <kbd>⬆️</kbd>, <kbd>⬇️</kbd>, <kbd>⬅️</kbd>, <kbd>➡️</kbd>
        </th>
        <th>Move cursor</th>
    </tr>
     <tr>
        <th><kbd>SPACE</kbd></th>
        <th>Open cell</th>
    </tr>
     <tr>
        <th><kbd>f</kbd></th>
        <th>Flag cell</th>
    </tr>
     <tr>
        <th><kbd>q</kbd></th>
        <th>Quit</th>
    </tr>
</table>

## 🎨 Customize!
The file [prep.def](prep.def) can be used to customize some of the parameters the program is compiled with. After editing you must recompile to see the changes. You can change cursor style, board size, etc. The file follows standard Ada syntax. Example:
```shell
BOARD_WIDTH := 10
CURSOR_RIGHT := "{"
```
