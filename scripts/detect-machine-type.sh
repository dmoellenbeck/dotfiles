#!/usr/bin/env bash
#
# detect-machine-type.sh
#
# Detects the machine type for machine-specific configurations.
# Used by setup.sh to install appropriate Brewfiles.
#
# Detection Strategy (Priority Order):
#   1. Explicit config file (~/.machine-type)
#   2. Environment variable ($MACHINE_TYPE)
#   3. Hardware detection (sysctl hw.model)
#   4. Work marker file (~/.work-machine) for MacBooks
#
# Machine Types:
#   - macmini           Mac Mini (server, Docker, 24/7 services)
#   - macbook-work      Work MacBook (employer provided)
#   - macbook-personal  Personal MacBook
#   - default           Unknown/other machines
#
# Usage:
#   source scripts/detect-machine-type.sh
#   machine_type=$(detect_machine_type)
#
#   # Or run directly:
#   ./scripts/detect-machine-type.sh
#
# Setup:
#   # Mac Mini
#   echo "macmini" > ~/.machine-type
#
#   # Work MacBook
#   echo "macbook-work" > ~/.machine-type
#   touch ~/.work-machine
#
#   # Personal MacBook
#   echo "macbook-personal" > ~/.machine-type
#
# Related:
#   - https://github.com/dmoellenbeck/home_lab/issues/1
#   - https://github.com/dmoellenbeck/home_lab/issues/2
#

set -e

detect_machine_type() {
  # Priority 1: Explicit config file
  if [[ -f "${HOME}/.machine-type" ]]; then
    cat "${HOME}/.machine-type"
    return 0
  fi

  # Priority 2: Environment variable
  if [[ -n "${MACHINE_TYPE}" ]]; then
    echo "${MACHINE_TYPE}"
    return 0
  fi

  # Priority 3: Hardware detection as fallback
  local model
  model=$(sysctl -n hw.model 2>/dev/null || echo "unknown")

  case "${model}" in
    Macmini*)
      echo "macmini"
      ;;
    MacBookAir* | MacBookPro*)
      # Priority 4: Check for work marker file
      if [[ -f "${HOME}/.work-machine" ]]; then
        echo "macbook-work"
      else
        echo "macbook-personal"
      fi
      ;;
    *)
      echo "default"
      ;;
  esac
}

# Get verbose machine info (useful for debugging)
get_machine_info() {
  local machine_type
  machine_type=$(detect_machine_type)

  echo "Machine Type Detection"
  echo "======================"
  echo "Detected Type:    ${machine_type}"
  echo "Hardware Model:   $(sysctl -n hw.model 2>/dev/null || echo 'unknown')"
  echo "Hostname:         $(scutil --get LocalHostName 2>/dev/null || hostname -s)"
  echo "Config File:      ${HOME}/.machine-type $([ -f "${HOME}/.machine-type" ] && echo "(exists: $(cat "${HOME}/.machine-type"))" || echo "(not found)")"
  echo "Work Marker:      ${HOME}/.work-machine $([ -f "${HOME}/.work-machine" ] && echo "(exists)" || echo "(not found)")"
  echo "Env Variable:     \$MACHINE_TYPE=${MACHINE_TYPE:-"(not set)"}"
}

# If sourced, export function. If executed, run detection.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  # Script is being run directly
  case "${1:-}" in
    --verbose | -v)
      get_machine_info
      ;;
    --help | -h)
      echo "Usage: $0 [OPTIONS]"
      echo ""
      echo "Detects the machine type for machine-specific configurations."
      echo ""
      echo "Options:"
      echo "  -v, --verbose    Show detailed machine info"
      echo "  -h, --help       Show this help message"
      echo ""
      echo "Machine Types:"
      echo "  macmini          Mac Mini server"
      echo "  macbook-work     Work MacBook (employer)"
      echo "  macbook-personal Personal MacBook"
      echo "  default          Unknown machine"
      ;;
    *)
      detect_machine_type
      ;;
  esac
fi
