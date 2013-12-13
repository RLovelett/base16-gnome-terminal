#!/usr/bin/env bash
# Base16 Twilight - Gnome Terminal color scheme install script
# David Hart (http://hart-dev.com)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Twilight Dark"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-twilight-dark"
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
gset string palette "#1e1e1e:#cf6a4c:#8f9d6a:#f9ee98:#7587a6:#9b859d:#afc4db:#a7a7a7:#5f5a60:#cf6a4c:#8f9d6a:#f9ee98:#7587a6:#9b859d:#afc4db:#ffffff"
gset string background_color "#1e1e1e"
gset string foreground_color "#a7a7a7"
gset string bold_color "#a7a7a7"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"
