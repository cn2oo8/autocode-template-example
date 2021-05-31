<%
    data.each {
        item ->
            println """${item.get(0)}("${item.get(1)}","${item.get(2)}"),"""
    }
%>
