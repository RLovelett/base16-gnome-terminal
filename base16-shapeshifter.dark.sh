#!/usr/bin/env bash
# Base16 shapeshifter - Gnome Terminal color scheme install script
# Tyler Benziger (http://tybenz.com)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 shapeshifter Dark"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-shapeshifter-dark"
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
gset string palette "#000000:#e92f2f:#0ed839:#dddd13:#3b48e3:#f996e2:#23edda:#ababab:#343434:#e92f2f:#0ed839:#dddd13:#3b48e3:#f996e2:#23edda:#f9f9f9"
gset string background_color "#000000"
gset string foreground_color "#ababab"
gset string bold_color "#ababab"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"
