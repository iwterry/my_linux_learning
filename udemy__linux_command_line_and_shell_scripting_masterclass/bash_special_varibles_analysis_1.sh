#!/bin/bash

echo '###### IFS unset #####'
unset IFS
echo '----- "$@" -----'
for item in "$@"; do echo "item: $item"; done
echo '----- $@ ------'
for item in $@; do echo "item: $item"; done
echo '----- "$*" -----'
for item in "$*"; do echo "item: $item"; done
echo '----- $* -----'
for item in $*; do echo "item: $item"; done

echo

echo '###### IFS set to null #######'
IFS=
echo '----- "$@" -----'
for item in "$@"; do echo "item: $item"; done
echo '----- $@ ------'
for item in $@; do echo "item: $item"; done
echo '----- "$*" -----'
for item in "$*"; do echo "item: $item"; done
echo '----- $* -----'
for item in $*; do echo "item: $item"; done

echo

echo '###### IFS set to _:_ #######'
IFS="_;_"
echo '----- "$@" -----'
for item in "$@"; do echo "item: $item"; done
echo '----- $@ ------'
for item in $@; do echo "item: $item"; done
echo '----- "$*" -----'
for item in "$*"; do echo "item: $item"; done
echo '----- $* -----'
for item in $*; do echo "item: $item"; done

unset IFS
