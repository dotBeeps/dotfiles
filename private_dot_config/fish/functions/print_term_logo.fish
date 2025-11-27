function print_term_logo
    set SAVED_CURSOR (commandline --cursor)
    kitten icat --place 30x30@1x12 Pictures/termlogo.png
    commandline --cursor $SAVED_CURSOR
end
