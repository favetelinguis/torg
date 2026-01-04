# Create ~/torg ~/torg/archive and ~/torg/__daily.md
# Run git init in ~/torg
# Add ./archive to .gitignore
#
# Source this file from .zshrc or .bashrc and use with d

torg() {
    local previous_dir=$(pwd)
    cd ~/torg || return

    local file="./__daily.md"
    local current_date=$(date +"%Y-%m-%d")

    if [[ "$OSTYPE" = "darwin"* ]]; then
      # macOS syntax
      creation_date=$(stat -f "%SB" -t "%Y-%m-%d" "$file")
    else
      # Linux syntax
      creation_date=$(stat -c %w "$file" | cut -d ' ' -f1)
    fi

    if [ "$current_date" = "$creation_date" ]; then
        hx ./__daily.md
    else
        # Need to move before copy to update the creation date of the __daily.md file
        mv ./__daily.md ./archive/$creation_date.md
        cp ./archive/$creation_date.md  ./__daily.md
        hx ./__daily.md
    fi

    cd "$previous_dir"
}

source_torg() {
  source ~/torg.sh
}

alias d="torg"
