## <エスケープシーケンス>
## prompt_bang が有効な場合、!=現在の履歴イベント番号, !!='!' (リテラル)
# ${WINDOW:+"[$WINDOW]"} = screen 実行時にスクリーン番号を表示 (prompt_subst が必要)
# %/ or %d = ディレクトリ (0=全て, -1=前方からの数)
# %~ = ディレクトリ
# %h or %! = 現在の履歴イベント番号
# %L = 現在の $SHLVL の値
# %M = マシンのフルホスト名
# %m = ホスト名の最初の `.' までの部分
# %S (%s) = 突出モードの開始 (終了)
# %U (%u) = 下線モードの開始 (終了)
# %B (%b) = 太字モードの開始 (終了)
# %t or %@ = 12 時間制, am/pm 形式での現在時刻
# %n or $USERNAME = ユーザー ($USERNAME は環境変数なので setopt prompt_subst が必要)
# %N = シェル名
# %i = %N によって与えられるスクリプト, ソース, シェル関数で, 現在実行されている行の番号 (debug用)
# %T = 24 時間制での現在時刻
# %* = 24 時間制での現在時刻, 秒付き
# %w = `曜日-日' の形式での日付
# %W = `月/日/年' の形式での日付
# %D = `年-月-日' の形式での日付
# %D{string} = strftime 関数を用いて整形された文字列 (man 3 strftime でフォーマット指定が分かる)
# %l = ユーザがログインしている端末から, /dev/ プレフィックスを取り除いたもの
# %y = ユーザがログインしている端末から, /dev/ プレフィックスを取り除いたもの (/dev/tty* はソノママ)
# %? = プロンプトの直前に実行されたコマンドのリターンコード
# %_ = パーサの状態
# %E = 行末までクリア
# %# = 特権付きでシェルが実行されているならば `#', そうでないならば `%' == %(!.#.%%)
# %v = psvar 配列パラメータの最初の要素の値
# %{...%} = リテラルのエスケープシーケンスとして文字列をインクルード
# %(x.true-text.false-text) = 三つ組の式
# %<,>string>, %[xstring] = プロンプトの残りの部分に対する, 切り詰めの振る舞い
#         `<' の形式は文字列の左側を切り詰め, `>' の形式は文字列の右側を切り詰めます
# %c, %., %C = $PWD の後ろ側の構成要素

# .zshrc をコンパイルして .zshrc.zwc を生成するコマンド
# zcompile ~/.zshrc

# コマンドラインスタック（入力中コマンドをスタックに退避させる）
# ESC-q

# コマンド入力中にヘルプ（man）を見る
# ESC-h

# エディタとページャーのデフォルト設定
export EDITOR='vim'            # デフォルトのエディタをvimに設定
export VISUAL='vim'            # ビジュアルエディタもvimに設定
export PAGER='less'           # ページャーをlessに設定

# 基本的な環境変数の設定
export LANG=en_US.UTF-8        # システム全体の言語設定
export EDITOR='vim'            # デフォルトのエディタをvimに設定
export VISUAL='vim'            # ビジュアルエディタもvimに設定
export PAGER='less'           # ページャーをlessに設定

# パスの重複を防ぐ
# path と PATH の重複を防ぎ、パスの一意性を保証
typeset -U path PATH

##========================================================##
##================== キーバインドの設定 ==================##
##========================================================##
# カーソル移動を効率化するキーバインド設定
bindkey "^[[5C" forward-word   # Ctrl+右矢印キー：次の単語へ移動
bindkey "^f" forward-word      # Ctrl+f：次の単語へ移動
bindkey "^[[5D" backward-word  # Ctrl+左矢印キー：前の単語へ移動
bindkey "^b" backward-word     # Ctrl+b：前の単語へ移動

##========================================================##
##====================== 補完の設定 ======================##
##========================================================##
# 補完システムの初期化（キャッシュを活用して高速化）
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
    compinit                   # 補完データベースの再生成
else
    compinit -C               # キャッシュを使用して高速化
fi

# 補完機能の拡張
fpath=(/usr/local/share/zsh-completions $fpath)   # 追加の補完定義を読み込む

# 補完の詳細設定
zstyle ':completion:*' accept-exact '*(N)'        # 正確なマッチを優先
zstyle ':completion:*' use-cache on               # キャッシュを有効化
zstyle ':completion:*' cache-path ~/.zsh/cache    # キャッシュの保存先
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 大文字小文字を区別しない
zstyle ':completion:*:default' menu select=1      # 補完候補をカーソルで選択可能に
zstyle ':completion:*' use-cache true            # キャッシュを有効化
zstyle ':completion:*:processes' command 'ps x'   # プロセスの補完を強化
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}  # 補完候補に色付け
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'  # killコマンドの補完候補に色付け

# 補完の動作設定
setopt list_packed           # 補完候補を詰めて表示
unsetopt auto_remove_slash   # ディレクトリ名の末尾の / を自動的に削除しない
setopt auto_param_slash      # ディレクトリ名の補完で末尾に / を付加
setopt mark_dirs            # ディレクトリ名が補完対象の場合 / を付加
setopt list_types           # 補完候補のファイル種別を表示
unsetopt menu_complete      # 最初のタブで補完候補を即時挿入しない
setopt auto_list           # 補完候補を一覧表示
setopt auto_menu           # 補完キー連打で候補を順に表示
setopt auto_param_keys     # カッコの対応などを自動的に補完
setopt auto_resume         # サスペンド中のコマンドと同じものを実行で再開
unsetopt list_beep        # 補完時にビープ音を鳴らさない

##========================================================##
##==================== 予測補完の設定 ====================##
##========================================================##
# コマンドの予測入力機能
autoload -U predict-on      # 予測入力機能を有効化
zle -N predict-on
zle -N predict-off
bindkey '^xp'  predict-on   # Ctrl+x p で予測入力ON
bindkey '^x^p' predict-off  # Ctrl+x Ctrl+p で予測入力OFF

##========================================================##
##====================== 履歴の設定 ======================##
##========================================================##
HISTFILE=$HOME/.zsh_history  # 履歴ファイルの保存先
HISTSIZE=1000000             # メモリ上の履歴サイズ
SAVEHIST=1000000             # 保存される履歴のサイズ

# 履歴の動作設定
setopt extended_history      # 履歴に実行時刻を記録
setopt append_history       # 履歴を追加モードで保存
setopt inc_append_history   # コマンド実行時に即座に履歴を保存
setopt share_history       # 履歴を端末間で共有
setopt hist_ignore_all_dups # 重複するコマンドは古い方を削除
setopt hist_ignore_dups    # 直前と同じコマンドは履歴に追加しない
setopt hist_ignore_space   # スペースで始まるコマンドは履歴に追加しない
unsetopt hist_verify      # 履歴展開時に実行前確認しない
setopt hist_reduce_blanks # 余分な空白を除いて保存
setopt hist_save_no_dups  # 重複するコマンドは古い方を削除
setopt hist_no_store     # historyコマンドは履歴に登録しない
setopt hist_expand      # 補完時に履歴を展開

# 全履歴を表示するコマンド
function history-all { history -E 1 }

##========================================================##
##================ ディレクトリ移動の設定 ================##
##========================================================##
setopt auto_cd              # ディレクトリ名のみで移動可能に
setopt auto_pushd          # cd 時に自動的にディレクトリスタックに追加
setopt pushd_ignore_dups   # ディレクトリスタックに重複を追加しない
setopt pushd_to_home      # 引数なしの pushd で $HOME に移動
setopt pushd_silent       # pushd/popd 実行時にスタックを表示しない

##========================================================##
##====================== 雑多な設定 ======================##
##========================================================##
# 基本的な動作設定
setopt no_beep             # ビープ音を無効化
setopt complete_in_word    # 単語の途中でも補完
setopt extended_glob      # 拡張グロブを有効化
setopt brace_ccl         # ブレース展開を有効化
setopt equals           # =command を command のパス名に展開
setopt numeric_glob_sort # 数字を数値として解釈してソート
setopt path_dirs       # コマンドパスの解決を適切に行う
setopt print_eight_bit # 8ビット文字を適切に表示
setopt auto_name_dirs  # 名前付きディレクトリを有効化

# フロー制御関連
unsetopt flow_control     # Ctrl+S/Ctrl+Q によるフロー制御を無効化
setopt no_flow_control   # フロー制御を無効化（上記と同様）
setopt hash_cmds        # コマンドパスをキャッシュ

# その他のオプション
setopt bsd_echo        # BSD互換のecho
setopt no_hup         # ログアウト時にバックグラウンドジョブを終了しない
setopt notify        # バックグラウンドジョブの状態変化を即座に通知
setopt long_list_jobs # ジョブリストを詳細表示
setopt magic_equal_subst # = 以降でも補完可能に
setopt multios      # 複数のリダイレクトやパイプを使用可能に
setopt short_loops  # 短縮文法を許可
setopt always_last_prompt # プロンプトを保持したまま補完
setopt cdable_vars  # 先頭に ~ が付かない場合でもディレクトリとして補完
setopt sh_word_split # シェルの単語分割を有効化
setopt rm_star_wait  # rm * を実行する前に確認

# セキュリティ設定
umask 027           # ファイル作成時のデフォルトパーミッション設定

# システムリソース設定
ulimit -s unlimited # スタックサイズ制限を解除
limit coredumpsize 0 # コアダンプサイズを0に制限

# 文字化け対策
export G_FILENAME_ENCODING=@locale  # ファイル名のエンコーディングを設定

# less（ページャー）の設定
LESS=eFRX          # lessの動作オプション
export LESS
if type /usr/bin/lesspipe &>/dev/null
then
    LESSOPEN="| /usr/bin/lesspipe '%s'"    # ファイルタイプに応じた表示
    LESSCLOSE="/usr/bin/lesspipe '%s' '%s'" # クリーンアップ処理
    export LESSOPEN LESSCLOSE
fi

# Warp Terminal対策
if [[ "$TERM_PROGRAM" == "WarpTerminal" ]]; then
    unset preexec    # コマンド実行前フックを無効化
fi

# 開発環境の設定
if (( $+commands[rbenv] )); then
    eval "$(rbenv init - zsh)"  # Ruby環境管理ツールの初期化
fi

# 追加設定ファイルの読み込み
[[ -f ~/.dots/.zsh/aliases.zsh ]] && source ~/.dots/.zsh/aliases.zsh     # エイリアス設定
[[ -f ~/.dots/.zsh/functions.zsh ]] && source ~/.dots/.zsh/functions.zsh # 関数定義
[[ -f ~/.dots/.zsh/starship.zsh ]] && source ~/.dots/.zsh/starship.zsh   # プロンプト設定

# シンタックスハイライト
[[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Starshipプロンプトの設定
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"  # モダンなプロンプトを初期化
fi

