# Maintainer: ImFstAsFckBoi
# Contributor: ImFstAsFckBoi

pkgname="ada-minesweeper"
pkgver="1.1"
pkgrel="1"
pkgdesc="Minesweeper for the terminal written in Ada"
arch=("x86_64")
license=("MIT")
url="https://github.com/ImFstAsFckBoi/Ada-Minesweeper"
makedepends=("gcc-ada")
provides=("mine")
source=("git+$url.git#tag=v$pkgver")
sha256sums=("SKIP")

build() {
    make -C "$srcdir/Ada-Minesweeper" mine
}

check() {
    test -f "$srcdir/Ada-Minesweeper/mine"
}

package() {
    install -Dm755 "$srcdir/Ada-Minesweeper/mine" "$pkgdir/usr/bin/mine"
    install -Dm644 "$srcdir/Ada-Minesweeper/LICENSE" "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
