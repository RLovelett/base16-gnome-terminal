#!/usr/bin/env bash
# Base16 Green Screen - Gnome Terminal color scheme install script
# Chris Kempson (http://chriskempson.com)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Green Screen Light"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-greenscreen-light"
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
gset string palette "#00ff00:#007700:#00bb00:#007700:#009900:#00bb00:#005500:#00bb00:#007700:#007700:#00bb00:#007700:#009900:#00bb00:#005500:#001100"
gset string background_color "#00ff00"
gset string foreground_color "#005500"
gset string bold_color "#005500"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"
