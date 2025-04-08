
create_folder() {
    local path=$1
    mkdir -p "$path"
    printf "created %s\n" "$path"
}

folder_exists() {
    local path=$1
    if [ -d "$path" ]; then
        echo "$path exists"
        return 0
    else
        return 1
    fi
}

BASE_DIR="$PREFIX/TermUp"

echo "installing TermUp"

folder_exists "$BASE_DIR"||create_folder "$BASE_DIR"
folder_exists "$BASE_DIR/bin"||create_folder "$BASE_DIR/bin"
folder_exists "$BASE_DIR/etc"||create_folder "$BASE_DIR/etc"
folder_exists "$BASE_DIR/lib"||create_folder "$BASE_DIR/lib"

cp ./setup_termux.sh $BASE_DIR/lib&&echo "copied setup_termux.sh $BASE_DIR/lib"
cp -r ./.gyp $BASE_DIR/etc&&echo copied gyp $BASE_DIR/etc||exit 0
cp -r ./motd $BASE_DIR/etc&&echo copied motd $BASE_DIR/etc||exit 0

cat <<EOL > $PREFIX/bin/TermUp
bash $BASE_DIR/lib/setup_termux.sh
EOL
chmod +x $PREFIX/bin/TermUp
echo "installed successfully"
echo "type TermUp to start"
