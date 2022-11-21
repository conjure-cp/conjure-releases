#!/bin/bash

set -o errexit
set -o nounset


OS=$1
VERSION=$2




mkdir -p releases/conjure-$VERSION-$OS
(
cd releases/conjure-$VERSION-$OS
cp ~/.local/bin/conjure .
strip conjure
)




mkdir -p releases/conjure-$VERSION-$OS-with-solvers
(
cd releases/conjure-$VERSION-$OS-with-solvers

# conjure
cp ~/.local/bin/conjure .

# savile row
cp ~/.local/bin/savilerow .
cp ~/.local/bin/savilerow.jar .
mkdir -p lib ; cp ~/.local/bin/lib/trove.jar lib/

# solvers
cp ~/.local/bin/bc_minisat_all_release .
cp ~/.local/bin/boolector .
cp ~/.local/bin/cadical .
cp ~/.local/bin/fzn-chuffed .
cp ~/.local/bin/fzn-gecode .
cp ~/.local/bin/glucose .
cp ~/.local/bin/glucose-syrup .
cp ~/.local/bin/kissat .
cp ~/.local/bin/lingeling .
cp ~/.local/bin/minion .
cp ~/.local/bin/nbc_minisat_all_release .
cp ~/.local/bin/open-wbo .
cp ~/.local/bin/plingeling .
cp ~/.local/bin/treengeling .
cp ~/.local/bin/yices .
cp ~/.local/bin/yices-sat .
cp ~/.local/bin/yices-smt .
cp ~/.local/bin/yices-smt2 .
cp ~/.local/bin/z3 .

echo "Before stripping"
du -sh .

strip z3 yices-smt2 yices-smt yices-sat yices open-wbo nbc_minisat_all_release treengeling plingeling lingeling fzn-gecode fzn-chuffed kissat cadical boolector bc_minisat_all_release glucose glucose-syrup conjure

echo "After stripping"
du -sh .
)


(
cd releases
zip -9 -r conjure-$VERSION-$OS.zip conjure-$VERSION-$OS
zip -9 -r conjure-$VERSION-$OS-with-solvers.zip conjure-$VERSION-$OS-with-solvers
)

echo ""
echo "zip archives ready"
du -sh releases/conjure-$VERSION-$OS.zip releases/conjure-$VERSION-$OS-with-solvers.zip
