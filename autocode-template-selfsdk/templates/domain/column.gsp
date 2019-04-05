<%
    def tableDefine = tableModel.tableDefine
    def columns = tableDefine.columns
    Set excludes = ["id","status","operator","created","modified","concurrentVersion","dataVersion"]
%>package ${config.basePackage}.common.enums.columns;

/**
 * ${tableDefine.cnname} 列名
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
public enum ${tableDefine.id}Column implements Column {
<% columns.each {
    if(excludes.contains(it.dataName)) {
        return
    }
    %>
    /**  ${it.cnname}  **/
    ${it.dataName}("${it.columnName}","${it.cnname}"),<%}%>
    ;

    private String column;
    private String desc;

    ${tableDefine.id}Column(String column, String desc) {
        this.column = column;
        this.desc = desc;
    }

    @Override
    public String getColumn() {
        return column;
    }

    @Override
    public String getDesc() {
        return desc;
    }
}
