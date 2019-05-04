<%
    def varDomainName = tableNameUtil.lowerCaseFirst(tableDefine.id);
    def pkColumn = tableDefine.getPkColumn();
    def pkJavaType = tableNameUtil.getDataType(pkColumn?.columnType);

%>package ${config.basePackage}.manager${PubUtils.addStrAfterSeparator(config.category, ".")};

import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category, ".")}.${tableDefine.id};
import ${config.basePackage}.manager.BaseManager;

/**
 * ${tableDefine.cnname}Manager接口类
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
public interface ${tableDefine.id}Manager extends BaseManager<${tableDefine.id}>{

}
