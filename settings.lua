-- Set the path to the scripts foder
package.path = "./resources/?.lua"
-- ###################################



function conky_vars()

    border_COLOR = "orange" --options are green, blue, black, orange or default   
    
end

require 'lua-border'

function conky_main()
     conky_main_box()

end
