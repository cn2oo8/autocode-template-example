
/**
 * 构建器
 */
public static class ${data.className}Builder implements Builder<${data.className}> {

    private ${data.className} entity;

    public ${data.className}Builder() {
        this.entity = new ${data.className}();
    }

    /**
     * 创建构建器
     *
     * @return
     */
    public static ${data.className}Builder create() {
        return new ${data.className}Builder();
    }
<%
    data.fieldList.each{field->
        def dataName = field.dataName;
        def upperFistName=tableNameUtil.upperFirst(field.dataName)

%>
        public ${data.className}Builder ${field.dataName}(${field.fieldClass} ${dataName}){
            entity.set${upperFistName}(${dataName});
            return this;
        }
      <%
    }
%>
}