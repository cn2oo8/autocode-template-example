${snippetTemplateUtil.getTemplate('copyrightInfo')}
<%
    def varDomainName = tableNameUtil.lowerCaseFirst(tableDefine.id);
    def managerName = varDomainName + "Manager";
    def pkColumn = tableDefine.getPkColumn();
    def pkJavaType = tableNameUtil.getDataType(pkColumn?.columnType);
%>package ${config.basePackage}.sdk.service.test${PubUtils.addStrAfterSeparator(config.category, ".")}.testdata;

import ${config.basePackage}.mockloader.annotation.JsonFileData;
import ${config.basePackage}.mockloader.annotation.MockProvider;

/**
 * ${tableDefine.cnname} 测试数据提供者
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@MockProvider("${varDomainName}MockProvider")
public class ${tableDefine.id}MockProvider {

    @JsonFileData(sourceId = "sdk/${tableDefine.id}")
    public ${tableDefine.id}MockHolder mockDataHolder;


    public ${tableDefine.id}MockHolder getMockDataHolder() {
        return mockDataHolder;
    }

    public void setMockDataHolder(${tableDefine.id}MockHolder mockDataHolder) {
        this.mockDataHolder = mockDataHolder;
    }
}
