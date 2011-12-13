# A sample Guardfile
# More info at https://github.com/guard/guard#readme

rspec_opts = {
  cli:            '--colour --format documentation --fail-fast',
  version:        2,
  all_after_pass: false,
  all_on_start:   false,
  notify:         true
}

guard 'rspec', rspec_opts do
  
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^lib/transit/(.+)\.rb})     { |m| "spec/unit/#{m[1]}_spec.rb" }

  watch('spec/spec_helper.rb')  { "spec" }
  
end