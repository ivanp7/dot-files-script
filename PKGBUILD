# Maintainer:  ivanp7
# Contributor: ivanp7

pkgname=dot-files
pkgver=1
pkgrel=1
pkgdesc="Meta interface script for dot-files"
arch=('any')
license=('Unlicense')
depends=(coreutils)

source=('dot-files.sh')
md5sums=('3207834d9970e7fe718a837feb9d5b03')

package ()
{
    install -Dm 755 dot-files.sh "$pkgdir/usr/bin/dot-files.sh"
}

