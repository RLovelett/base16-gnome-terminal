#!/usr/bin/env bash
# Base16 Monokai - Gnome Terminal color scheme install script
# Wimer Hazenberg (http://www.monokai.nl)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Monokai Dark"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-monokai-dark"
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
gset string palette "#272822:#f92672:#a6e22e:#f4bf75:#66d9ef:#ae81ff:#a1efe4:#f8f8f2:#75715e:#f92672:#a6e22e:#f4bf75:#66d9ef:#ae81ff:#a1efe4:#f9f8f5"
gset string background_color "#272822"
gset string foreground_color "#f8f8f2"
gset string bold_color "#f8f8f2"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"
