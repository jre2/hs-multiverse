guard :shell, all_on_start: true, cmd: '--color' do
  watch /src\/.*\.l?hs$/ do |m|
    puts "-[ Compile #{m[0]} ]"
    `runghc -isrc -Wall #{m[0]}`

    puts "-[ Lint #{m[0]} ]"
    `hlint #{m[0]}`

    #puts "-[ Bench #{m[0]} ]"
    #`cabal bench`

    #puts "-[ Running #{m[0]} ]"
    #`cabal run`

    puts "-[ Done ]"
  end
end

# vim:ft=ruby
