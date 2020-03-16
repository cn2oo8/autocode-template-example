<%
    data.fieldList.each { it ->
        def upperFistName=tableNameUtil.upperFirst(it.dataName)
        println """     builder.${it.dataName}(src.get${upperFistName}());"""
    }
%>

