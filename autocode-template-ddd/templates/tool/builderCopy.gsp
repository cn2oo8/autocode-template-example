<%
    data.fieldList.each { field ->
        def dataName = field.dataName;
        def upperFistName = tableNameUtil.upperFirst(field.dataName)
        println """ builder.${field.dataName}(src.get${upperFistName}());"""
    }
%>

