<%
    def tableDefine = tableModel.tableDefine;
    def columns = tableDefine.columns;
    columns.each { column ->

%>${column.columnName}    ${column.columnType}(${column.length})    ${column.comment}
<%

    };

%>