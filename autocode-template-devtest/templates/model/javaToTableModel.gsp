<?xml version="1.0" encoding="UTF-8" ?>
<tableModel>
    <tableDefine id='${data.className}' cnname='${data.className}' dbTableName='${tableNameUtil.convertToDbNames(data.className)}'>
        <%
            def columnNameList = []
            data.fieldList.each { it ->
            def columnName = tableNameUtil.convertToDbNames(it.dataName).toLowerCase();
            columnNameList.add(columnName)
        %>
        <column dataName='${it.dataName}' columnName='${columnName}' cnname='${it.comment}' columnType='${tableNameUtil.transToColumnType(it.fieldClass)}'
                canBeNull='false' readonly='false' isPK='false' jspTag='TEXT' comment='${it.dataName}'/><%
            }
            def columnNames = StringUtils.join(columnNameList, ",");
        %>

    </tableDefine>
    <orderColumns>
        <orderColumn orderType='desc'>id</orderColumn>
    </orderColumns>
    <bizFieldsMap>
        <bizFields key='createTime'>created</bizFields>
        <bizFields key='updateTime'>modified</bizFields>
        <bizFields
                key='queryList'>${columnNames}</bizFields>
        <bizFields
                key='addList'>${columnNames}</bizFields>
        <bizFields
                key='updateList'>${columnNames}</bizFields>
        <bizFields
                key='viewList'>${columnNames}</bizFields>
        <bizFields key='searchKey'>${columnNames}</bizFields>
        <bizFields
                key='allColumn'>${columnNames}</bizFields>
    </bizFieldsMap>

</tableModel>