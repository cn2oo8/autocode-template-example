<%
    println """ add str:"""
    println customTool.addon('hello')

    println """ changed list:"""
    customData.changeList.each { it ->
        println it;
    }

%>