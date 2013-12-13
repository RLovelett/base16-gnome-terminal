#!/usr/bin/env bash
# Base16 Railscasts - Gnome Terminal color scheme install script
# Ryan Bates (http://railscasts.com)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Railscasts Dark"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-railscasts-dark"
[[ -z "$GCONFTOOL" ]] && GCONFTOOL=gconftool
[[ -z "$BASE_KEY" ]] && BASE_KEY=/apps/gnome-terminal/profiles

PROFILE_KEY="$BASE_KEY/$PROFILE_SLUG"

gset() {
  local type="$1"; shift
  local key="$1"; shift
  local val="$1"; shift

  "$GCONFTOOL" --set --type "$type" "$PROFILE_KEY/$key" -- "$val"
}

# Because gconftool doesn't have "append"
glist_append() {
  local type="$1"; shift
  local key="$1"; shift
  local val="$1"; shift

  local entries="$(
    {
      "$GCONFTOOL" --get "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
      echo "$val"
    } | head -c-1 | tr "\n" ,
  )"

  "$GCONFTOOL" --set --type list --list-type $type "$key" "[$entries]"
}

# Append the Base16 profile to the profile list
glist_append string /apps/gnome-terminal/global/profile_list "$PROFILE_SLUG"

gset string visible_name "$PROFILE_NAME"
gset string palette "#2b2b2b:#da4939:#a5c261:#ffc66d:#6d9cbe:#b6b3eb:#519f50:#e6e1dc:#5a647e:#da4939:#a5c261:#ffc66d:#6d9cbe:#b6b3eb:#519f50:#f9f7f3"
gset string background_color "#2b2b2b"
gset string foreground_color "#e6e1dc"
gset string bold_color "#e6e1dc"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"
