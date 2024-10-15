# Maintainer: ImFstAsFckBoi
# Contributor: ImFasFckBoi

pkgname="ada-minesweeper"
pkgver=1.1
pkgrel=1
pkgdesc="Minesweeper for the terminal written in Ada"
arch=(x86_64)
license=("MIT")
url="https://github.com/ImFstAsFckBoi/Ada-Minesweeper"
makedepends=(gcc-ada)
source=()

build() {
    make -C "$srcdir/../"
}

check() {
    test -f "$srcdir/../mine"
}

package() {
    mkdir -p "$pkgdir/usr/bin/"
    install -p -m755 "$srcdir/../mine" "$pkgdir/usr/bin/"
    install -Dm644 "$srcdir/../LICENSE" "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
