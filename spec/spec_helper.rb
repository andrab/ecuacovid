def nu!
  @bin ||= find_binary { "#{ENV['HOME']}/code/nushell/nushell/target/debug/nu" }
end

def find_binary(program = "nu")
  extensions = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']

  ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
    extensions.each do |extension|
      binary = File.join(path, "#{program}#{extension}")
      return binary if File.executable?(binary) && !File.directory?(binary)
    end
  end

  return yield if block_given?
end
