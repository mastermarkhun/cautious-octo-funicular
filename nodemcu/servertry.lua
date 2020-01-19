uart.setup(0, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 0)

if srv then srv:close() srv=nil end
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)

    conn:on("receive", function(conn,request)
        urlcommand = string.sub(request,string.find(request,"GET /")
        +5,string.find(request,"HTTP/")-2)

        --[[ local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
         _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end

        urlcommand = path ]]

        if urlcommand ~= '' then
            if not string.match(urlcommand,"favicon.ico") then
                urlcommand = string.gsub(urlcommand, "%%20", " ")
                uart.write(0,urlcommand.."\r")
            end
        end
        urlcommand = nil

        conn:send("HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n");
    end)
    
    conn:on("sent",function(conn)
        local f = file.open("test.html","r")
        conn:send(file.read())
        file.close()
        conn:close();
        collectgarbage();
    end)

end)
