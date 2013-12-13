require 'fileutils'

def write_var_to_file(scheme_name, file_name, file_contents)
  path = File.join('colors', scheme_name)
  FileUtils.mkdir_p(path)
  file_name = File.join(path, file_name)
  File.open(file_name, 'w+') do |f|
    f.write(file_contents)
  end
end

filenames = Dir['*.dark.sh']

filenames.each do |name|
  raw = IO.read(name)

  scheme = name.match(/^base16-(\S+)\.dark\.sh$/).captures.first
  palette = raw.match(/palette\b\s+\"(.+)\"$/).captures.first.split(':').map { |split| "\'#{split.upcase}\'" }.join(', ')
  background_color = raw.match(/background_color\b\s+\"(.+)\"$/).captures.first.upcase
  foreground_color = raw.match(/foreground_color\b\s+\"(.+)\"$/).captures.first.upcase
  bold_color = raw.match(/bold_color\b\s+\"(.+)\"$/).captures.first.upcase
  bold_color_same_as_fg = raw.match(/bold_color_same_as_fg\b\s+\"(.+)\"$/).captures.first
  use_theme_colors = raw.match(/use_theme_colors\b\s+\"(.+)\"$/).captures.first
  use_theme_background = raw.match(/use_theme_background\b\s+\"(.+)\"$/).captures.first

  write_var_to_file(scheme, 'palette', palette)
  write_var_to_file(scheme, 'background_color', background_color)
  write_var_to_file(scheme, 'foreground_color', foreground_color)
  write_var_to_file(scheme, 'bold_color', bold_color)
  write_var_to_file(scheme, 'bold_color_same_as_fg', bold_color_same_as_fg)
  write_var_to_file(scheme, 'use_theme_colors', use_theme_colors)
  write_var_to_file(scheme, 'use_theme_background', use_theme_background)
end
