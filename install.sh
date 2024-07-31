
create_folder() {
    local path=$1
    mkdir -p "$path"
    printf "created $path\n"
}

BASE_DIR="$PREFIX/TermUp"

echo "installing TermUp"

create_folder "$BASE_DIR"
create_folder "$BASE_DIR/bin"
create_folder "$BASE_DIR/etc"
create_folder "$BASE_DIR/lib"

cp ./setup_termux.sh $BASE_DIR/lib
echo "copyed setup_termux.sh $BASE_DIR/lib"

cp -r ./.gyp $BASE_DIR/etc

cat <<EOL > $PREFIX/bin/TermUp
bash $BASE_DIR/lib/setup_termux.sh
EOL
chmod +x $PREFIX/bin/TermUp
echo "installed successfully"
echo "type TermUp to start"
