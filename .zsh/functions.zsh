# Create Video of hevc
hevc-convert () {

  filename="basename $@"
  extension=${filename##*.}
  filenameWithoutExt=${filename%.*}
  transferedFilename="$filenameWithoutExt-hevc.$extension"

  codec=`ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 $1`

  if [ $codec = 'h264' ]; then
      ffmpeg -i "$1" -c:v libx265 -preset fast -crf 28 -tag:v hvc1 -c:a eac3 -b:a 224k "$transferedFilename"
  fi
}

# 便利な関数の定義
# ディレクトリの作成と移動を同時に行う
function mkcd() {
    mkdir -p "$@" && cd "$_"
}


# gitリポジトリのルートディレクトリに移動
function cdgit() {
    local git_root=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -n "$git_root" ]; then
        cd "$git_root"
    else
        echo "Not in a git repository"
    fi
}

# プロセスを名前で検索
function psg() {
    ps aux | grep -i "$@" | grep -v grep
}

# ターミナルのタイトルを変更
function title() {
    echo -ne "\033]0;$*\007"
}

# 圧縮ファイルを自動判別して展開
function extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# ポートを使用しているプロセスを検索
function port() {
    lsof -i ":$1"
}

