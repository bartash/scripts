# detect_env.sh

detect_env() {
    case "$(uname -s)" in
        CYGWIN*)
            echo "cygwin"
            ;;
        MINGW*|MSYS*)
            echo "msys"
            ;;
        Linux*)
            if [[ -n "$WSL_DISTRO_NAME" ]] || grep -qiE "(microsoft|wsl)" /proc/version 2>/dev/null; then
                echo "wsl"
            else
                echo "linux"
            fi
            ;;
        Darwin*)
            echo "macos"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}