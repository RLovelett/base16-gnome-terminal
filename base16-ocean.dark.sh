#!/usr/bin/env bash
# Base16 Ocean - Gnome Terminal color scheme install script
# Chris Kempson (http://chriskempson.com)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Ocean Dark"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-ocean-dark"
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
gset string palette "#2b303b:#bf616a:#a3be8c:#ebcb8b:#8fa1b3:#b48ead:#96b5b4:#c0c5ce:#65737e:#bf616a:#a3be8c:#ebcb8b:#8fa1b3:#b48ead:#96b5b4:#eff1f5"
gset string background_color "#2b303b"
gset string foreground_color "#c0c5ce"
gset string bold_color "#c0c5ce"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"
