<%
    data.fieldList.each { it ->
        def upperFistName=tableNameUtil.upperFirst(it.dataName)
        println """     dest.set${upperFistName}(src.get${upperFistName}());"""
    }
%>

