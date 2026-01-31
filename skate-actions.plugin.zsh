# Add completions to fpath so they are available immediately
fpath+=( "${0:h}/completions" )

# Check for the skate binary
if (( ! $+commands[skate] )); then
  # Print a subtle warning (only in interactive shells)
  [[ -t 1 ]] && echo "[skate-actions] Warning: 'skate' binary not found. Please install it from charm.sh"
else
  # Define the functionality ONLY if the binary exists
  skget() {
      local val=$(skate get "$1" 2>/dev/null)

      if [[ -z "$val" ]]; then
          return 1
      fi

      case "$val" in
          shell:*)
              local cmd="${val#shell:}"
              eval "$cmd"
              ;;
          *)
              echo "$val"
              ;;
      esac
  }
fi
